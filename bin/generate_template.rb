#!/usr/bin/env ruby

require "rubygems"
require "erb"
require "pathname"
require "base64"

class Application

  def initialize
    @ext_rails_template_file = "ext_rails_template.rb"
    @rails_directory = File.expand_path(File.join(File.dirname(__FILE__), '..', 'rails'))
  end

  def main
    output_file_name = File.expand_path(File.join(File.dirname(__FILE__), '..', @ext_rails_template_file))
    erb_template = File.expand_path(File.join(File.dirname(__FILE__), "ext_rails_template.erb"))

    erb_content = File.open(erb_template, "r").read

    erb = ERB.new(erb_content, 0, "%")
    output_content = erb.result(binding)

    File.open(output_file_name, "w") do |f|
      f.write(output_content)
    end

    puts "File #{@ext_rails_template_file} was generated"
  end

  def add_file(pattern)
    result = ""
    Dir.glob(File.join(@rails_directory, pattern)) do |file_name|
      rails_file_name = Pathname.new(file_name).relative_path_from(Pathname.new(@rails_directory))
      result << make_file_item(rails_file_name)
    end
    result
  end

  def make_file_item(rails_file_name)
    file_name = File.join(@rails_directory, rails_file_name)
    content = File.open(file_name, "r").read

    <<-EOF
file "#{rails_file_name}", %q{
#{content}
}

    EOF
  end

  def add_binary_file(rails_file_name)
    file_name = File.join(@rails_directory, rails_file_name)
    content = File.open(file_name, "rb").read
    content = Base64.encode64(content)

    <<-EOF
binary_file "#{rails_file_name}", <<-FILE_CONTENT
#{content}
FILE_CONTENT

    EOF
  end
  
end

Application.new.main