
class App < Sinatra::Base

  get '/?' do
    if session[:movies] and session[:movies].is_a? Array
      puts session[:movies]
    else
      reader = Reader.new
      movies = reader.load
      rotten = Rotten.new
      session[:movies] = rotten.go movies
    end

    erb :'index'
  end

end
