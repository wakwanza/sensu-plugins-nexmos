#!/usr/bin/env ruby
#
#   handler-nexmos.rb
#
# DESCRIPTION:
#   Delivers SMS and voice alerts for events notification
#
# PLATFORMS:
#   All
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem: nexmo
#
#
# LICENSE:
#   Abdulrahim Umar  @github/wakwanza
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#
require 'rubygems' if RUBY_VERSION < '1.9.0'
require 'sensu-handler'
require 'nexmo'

class Nexmos < Sensu::Handler
  option :json_config, description: 'Confguration name', short: '-j JSONCONFIG', long: '--json JSONCONFIG', default: 'nexmos'

  def short_name
    @event['client']['name'] + '/' + @event['check']['name']
  end

  def action_to_string
    @event['action'].eql?('resolve') ? 'RESOLVED' : 'ALERT'
  end

  def status_to_string
    case @event['check']['status']
    when 0
      'OK'
    when 1
      'WARNING'
    when 2
      'CRITICAL'
    else
      'UNKNOWN'
    end
  end

  def build_textmessage
    "Sensu #{action_to_string}: #{short_name} :: #{status_to_string} \
       (#{@event['client']['address']})"
  end

  def build_voicemessage
    breather = '<break time=\"2s\"/>'
    "Sensu #{breather} #{action_to_string},#{short_name} #{status_to_string}\
       #{breather} (#{@event['client']['address']})"
  end

  def build_call_list(c_block)
    rcs = []
    c_block.each do |mobile, c|
      if (c['sensu_roles'].include?('all') ||
         ((c['sensu_roles'] & @event['check']['subscribers']).!empty?) ||
         (c['sensu_checks'].include?(@event['check']['name']))) &&
         (c['sensu_level'] >= @event['check']['status'])
        rcs << mobile
      end
    end
    rcs
  end

  def read_credentials
    par = {
      n_api_key: ENV.fetch('NEXMO_API_KEY') || settings[config[:json_config]]['api_key'],
      n_api_secret: ENV.fetch('NEXMO_API_SECRET') || settings[config[:json_config]]['api_secret']
    }
    par
  end

  def handle
    params = read_credentials
    voice_status = settings[config[:json_config]]['voice'] || false
    candidates = settings[config[:json_config]]['recipients']
    recipients = build_call_list candidates
    message = voice_status ? build_voicemessage : build_textmessage
    nxmc = Nexmo::Client.new params[:n_api_key], params[:n_api_secret]

    recipients.each do |recepient|
      begin
        msg = { to: recepient, text: message }
        voice_status ? nxmc.initiate_tts_call(msg) : nxmc.send_message(msg)
        puts "Notification to #{recipient} for #{action_to_string} sent"
      rescue => e
        puts "Notification failed with  #{e.message}"
      end
    end
  end
end
