require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:default) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
end
