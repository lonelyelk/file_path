#!/usr/bin/env ruby

Gem::Specification.new do |s|
    s.name = "file_path"
    s.summary = "FilePath is a ruby class to simplify file path interaction"

    s.version = "0.1"
    s.date = "2009-07-06"
    s.author = "Sergey Kruk"
    s.email = "sergey.kruk@gmail.com"
    s.homepage = "http://github.com/lonelyelk/file_path"
    
    s.has_rdoc = true
    s.rdoc_options << "--main" << "README.rdoc"
    s.rdoc_options << "--charset" << "UTF-8"
    s.rdoc_options << "--webcvs" << "http://github.com/lonelyelk/file_path/tree/master"
    s.extra_rdoc_files = [ "README.rdoc", "LICENSE" ]
    
    s.files = %w(LICENSE README.rdoc Rakefile lib lib/file_path.rb spec spec/file_path_spec.rb spec/spec.opts)
end
