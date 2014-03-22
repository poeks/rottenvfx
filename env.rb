require 'rubygems'
require 'bundler'
require 'yaml'

Bundler.setup
Bundler.require

require './app'
require './lib/reader'
require './lib/rotten'

CONFIG = YAML.load_file './config.yml'
KEY = YAML.load_file './key.yml'

class App < Sinatra::Base
  configure do
    enable :sessions
  end
end
