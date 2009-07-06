#!/usr/bin/env ruby

require 'rubygems'
require 'spec/rake/spectask'
require 'rake/rdoctask'

desc "Run all specs"
Spec::Rake::SpecTask.new do |t|
    t.spec_files = Dir.glob(File.join("spec", "*_spec.rb"))
    t.spec_opts = ['--options', 'spec/spec.opts']
end

desc "Generate RDoc"
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include(Dir.glob(File.join("lib", "*.rb"))).
                  include("README.rdoc", "LICENSE")
  rdoc.main = "README.rdoc"
  rdoc.rdoc_dir = "rdoc"
  rdoc.options << "--charset=UTF-8"
  rdoc.options << "--inline-source"
  rdoc.title = "FilePath"
end
