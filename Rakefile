require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require 'merb-core/version'
require 'merb-core/tasks/merb_rake_helper'
require "extlib"
require "spec/rake/spectask"

load File.join(File.dirname(__FILE__), 'merb_max.gemspec')

NAME = @spec.name
GEM_VERSION = @spec.version

Rake::GemPackageTask.new(@spec) do |pkg|
  pkg.gem_spec = @spec
end

desc "install the plugin locally"
task :install => [:package] do
  sh %{sudo gem install #{install_home} pkg/#{NAME}-#{GEM_VERSION} --no-update-sources}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

namespace :jruby do

  desc "Run :package and install the resulting .gem with jruby"
  task :install => :package do
    sh %{#{sudo} jruby -S gem install #{install_home} pkg/#{NAME}-#{GEM_VERSION}.gem --no-rdoc --no-ri}
  end

end

##############################################################################
# Specs
##############################################################################
desc "Run all specs"
Spec::Rake::SpecTask.new("specs") do |t|
  t.spec_opts = ["--format", "specdoc", "--colour"]
  t.spec_files = Dir["spec/**/*_spec.rb"].sort
end

desc "Run all specs and generate an rcov report"
Spec::Rake::SpecTask.new('rcov') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ["--format", "specdoc", "--colour"]
  t.rcov = true
  t.rcov_dir = 'coverage'
  t.rcov_opts = ['--exclude', 'gems', '--exclude', 'spec']
end
