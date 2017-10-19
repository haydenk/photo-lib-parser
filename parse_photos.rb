#!/usr/bin/env ruby

require_relative 'config/boot'
require 'digest'

base_dir = Dir.pwd

images = %w(image/jpeg image/png image/gif)
videos = %w(video/quicktime video/mp4)

@count=0

Dir["#{base_dir}/files/**/*"].each do |f|
  if File.exist?(f) && File.file?(f)

    begin

      extension = File.extname(f).downcase
      mime_type = Rack::Mime.mime_type(extension)

      photo = nil

      if images.include?(mime_type)
        photo = Image.new(f, base_dir)
      elsif videos.include?(mime_type)
        photo = Video.new(f, base_dir)
      end

      unless photo.nil?
        if photo.save!
          @count = @count+1
        end
      end

    rescue => error
      puts "Error with file: #{f}"
    end

  end
end

puts @count