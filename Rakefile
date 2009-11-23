# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))
#require(File.join(RAILS_ROOT, 'vendor', 'gems', 'jscruggs-metric_fu-1.1.5', 'lib', 'metric_fu'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

require 'thinking_sphinx/tasks'

#MetricFu::Configuration.run do |config| 
#  config.rcov[:rcov_opts] << "-Itest" 
#end