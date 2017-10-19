#!/usr/bin/env ruby

require_relative 'config/boot'

files = Photo.all

files.each do |f|
  if Photo.count(:file_hash => f.file_hash) > 1 && File.exist?("#{Dir.pwd}/#{f.path}")
    File.delete(File.absolute_path "#{Dir.pwd}/#{f.path}")
    f.destroy!
  end
end