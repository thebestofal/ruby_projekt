require 'rake/testtask'
require 'rspec/core/rake_task'

task default: %w[spec]
 
RSpec::Core::RakeTask.new(:spec) do |t|
t.pattern = Dir.glob('spec/*_test.rb')
t.rspec_opts = %w["--format documentation"]

end