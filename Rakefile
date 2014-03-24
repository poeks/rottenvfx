
task :env do
  require File.join File.dirname(__FILE__), 'env'
end

task :search => :env do
  puts "Searching for #{ENV["movie"]}"
  rot = Rotten.new
  require 'json'
  puts JSON.pretty_generate MultiJson.load rot.fetch ENV["movie"]
end

task :get_all_movies => :env do

  reader = Reader.new
  movies = reader.load
  rotten = Rotten.new
  movies = rotten.go movies

end

desc 'migrate database back to blank slate'
task :reset => :env do

  Sequel.extension :migration
  Sequel::Migrator.run(DB, 'migrations', :target => 0)
  Sequel::Migrator.run(DB, 'migrations')
  puts "DB Reset!"

end
