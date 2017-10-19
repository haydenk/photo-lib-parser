ENV['RACK_ENV'] ||= 'development'

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require 'data_mapper' # metagem, requires common plugins too.
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

# Load the helpers
Dir['./app/helper/*.rb'].each { |f| require f }

if ENV['RACK_ENV'] == 'production'
  DataMapper.setup(:default, ENV['DATABASE_URL'])
else
  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/app.db")
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models

# Load the models
Dir['./app/model/*.rb'].each { |f| require f }
DataMapper.finalize