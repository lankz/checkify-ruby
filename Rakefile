require "bundler/gem_tasks"

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)
task default: :spec

desc "Regenerate the client with OpenAPI Generator 7.21.0"
task :generate do
  ruby "script/generate"
end
