#!/usr/bin/env ruby

require 'asciidoctor-pdf'
require 'fileutils'

if ARGV.size < 2
  puts "Usage: ruby gather_adoc_files.rb /path/to/input/folder /path/to/output/folder"
  exit
end

input_folder = ARGV[0]
output_folder = ARGV[1]


unless File.directory?(input_folder)
  puts "Error: The specified folder does not exist."
  exit(1)
end

unless File.directory?(output_folder)
  Dir.mkdir(output_folder)
end

script_directory = File.dirname(__FILE__)
image_extensions = ['.svg', '.png', '.jpeg']


cache_dir = File.expand_path(File.join(script_directory, "cache"))

unless File.directory?(cache_dir)
  FileUtils.mkdir_p(cache_dir)
end


adoc_files = Dir.glob(File.join(input_folder, '**', '*.adoc'))

adoc_files.each do |adoc_file|
  adoc_directory = File.dirname(adoc_file)
  
  files_to_move = image_extensions.flat_map do |ext|
    Dir.glob(File.join(adoc_directory, '*' + ext))
  end

  files_to_move.each do |file|
    FileUtils.cp(file, cache_dir)
  end


  pdf_file = File.join(output_folder, File.basename(adoc_file, '.adoc') + '.pdf')
  

  additional_attributes = {
    'imagesdir' => cache_dir,
    "preface-title" =>  "Preface",
    "icons" => "font",
    "doctype" => "article",
    "source-highlighter" => "rouge",
    "rouge-style" =>"monokai"
  }

  begin
    Asciidoctor.convert_file(
      adoc_file,
      to_file: pdf_file,
      backend: 'pdf',
      attributes: additional_attributes,
      safe: :unsafe
    )

    puts "Converted #{adoc_file} to #{pdf_file}"
  rescue NoMethodError => e
    puts "Error: #{e.message}"

    Asciidoctor.convert_file(
      adoc_file,
      to_file: pdf_file,
      backend: 'pdf',
      attributes: additional_attributes,
      safe: :unsafe,
    )
  ensure
    # Clearing of the cache provoking image-read problem
    # FileUtils.rm_rf(cache_dir)
  end
end