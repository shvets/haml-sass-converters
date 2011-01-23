# Rakefile for haml-sass-converters-rubymine-plugin

require 'rubygems' unless RUBY_VERSION =~ /1.9.*/

project_name = "haml-sass-converters"

task :default => :gemspec

begin
  require 'bundler'

  begin
    require 'jeweler'

    Jeweler::Tasks.new do |gemspec|
      gemspec.name = project_name
      gemspec.summary = "Provides convenient converters for HAML/SASS as plugin for RubyMine IDE (Summary)."
      gemspec.description = "Provides convenient converters for HAML/SASS as plugin for RubyMine IDE."
      gemspec.email = "alexander.shvets@gmail.com"
      gemspec.homepage = "http://github.com/shvets/#{project_name}"
      gemspec.authors = ["Alexander Shvets"]
      gemspec.files = FileList["CHANGES", "#{project_name}.gemspec", ".rvmrc",
                               "Rakefile", "README", "VERSION", "bin/**/*", "lib/**/*"]

      gemspec.executables = ['haml-sass-converters-install']
      gemspec.requirements = ["none"]
      gemspec.bindir = "bin"

      gemspec.add_bundler_dependencies
    end
  rescue LoadError
    puts "Jeweler not available. Install it s with: [sudo] gem install jeweler"
  end
rescue LoadError
  puts "Bundler not available. Install it s with: [sudo] gem install bundler"
end

desc "Release the gem"
task :"release:gem" => [:gemspec, :build] do
  require 'jruby/openssl/gem_only'

  %x(
      git add .
  )
  puts "Commit message:"
  message = STDIN.gets

  version = "#{File.open(File::dirname(__FILE__) + "/VERSION").readlines().first}"

  %x(
    git commit -m "#{message}"

    git push origin master

    gem push pkg/#{project_name}-#{version}.gem
  )
end


