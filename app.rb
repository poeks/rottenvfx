
class App < Sinatra::Base

  get '/?' do
    @movies = Movie.order(Sequel.desc :critics_score).all
    erb :'index'
  end

end
