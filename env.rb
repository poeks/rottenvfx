require 'rubygems'
require 'bundler'
require 'yaml'
require 'logger'

Bundler.setup
Bundler.require

CONFIG = YAML.load_file './config.yml'
KEY = YAML.load_file './key.yml'

db_config = KEY["database"]
logger = Logger.new($stdout)
connect_opts = {
  loggers: logger,
  sql_log_level: :debug
}
DB = Sequel.connect db_config, connect_opts

require './app'
require './lib/reader'
require './lib/rotten'
require './lib/movie'

class App < Sinatra::Base
  configure do
    enable :sessions
  end
end
