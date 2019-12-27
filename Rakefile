require 'rake/testtask'
require 'rspec/core/rake_task'

task default: %w[test spec]

Rake::TestTask.new do |task|
 task.pattern = 'test/*_test.rb'
end
 
RSpec::Core::RakeTask.new(:spec) do |t|
t.pattern = Dir.glob('spec/*_test.rb')
t.rspec_opts = '--format d'

end