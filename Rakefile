require "bundler/gem_tasks"
require "rake/testtask"
require "rubocop/rake_task"
require "rspec/core/rake_task"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

begin
  args = if RUBY_VERSION >= '2.0.0'
           [:spec, :make_bin_executable, :rubocop, :check_binstubs]
         else
           [:spec, :make_bin_executable, :rubocop]
         end
end

RuboCop::RakeTask.new

RSpec::Core::RakeTask.new(:spec) do |r|
  r.pattern = FileList['**/**/*_spec.rb']
end

desc 'Make all plugins executable'
task :make_bin_executable do
  `chmod -R +x bin/*.rb`
end

desc 'Test for binstubs'
task :check_binstubs do
  bin_list = Gem::Specification.load('sensu-plugins-nexmos.gemspec').executables
  bin_list.each do |b|
    `which #{ b }`
    unless $CHILD_STATUS.success?
      puts "#{b} was not a binstub"
      exit
    end
  end
end

task default: args
