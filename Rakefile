require "cucumber/rake/task"
require "rake/clean"
# require the hydra codebase


CLEAN = FileList['*.log']

Cucumber::Rake::Task.new(:smoke) do |task|
  task.cucumber_opts = ("-p production features/smoke.feature")
end

Cucumber::Rake::Task.new(:unit) do |task|
  task.cucumber_opts = ("-p production features/unit/general.feature")
end

