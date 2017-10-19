class Photo
  include DataMapper::Resource

  property :id, Serial
  property :filename, String
  property :path, String
  property :extension, String
  property :mime_type, String
  property :file_size, Integer
  property :file_hash, String, :length => 1..128
  property :type, Discriminator

  def initialize(file, base_dir)
    self.path = file.gsub("#{base_dir}", '.')
    self.filename = File.basename file
    self.extension = File.extname(file).downcase
    self.mime_type = Rack::Mime.mime_type(self.extension)
    self.file_size = File.size?(file)
    self.file_hash = Digest::SHA512.hexdigest File.read(file)
  end
end

class Image < Photo; end
class Video < Photo; end
