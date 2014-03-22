class Rotten

  def initialize
    @limit = 200
    @conn = Faraday.new(:url => CONFIG["rotten_url"]) do |faraday|
      faraday.request  :url_encoded
      #faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def go movies
    results = []
    movies.each_with_index do |movie, i|
      return results if i >= @limit
      results << search(movie)
      sleep 1
    end

    results
  end

  #?q={search-term}&page_limit={results-per-page}&page={page-number}"}
  def search movie
    params = {
      apikey: KEY["rotten_key"],
      q: movie,
      page_limit: 1,
      page: 1
    }
    results = @conn.get CONFIG["rotten_path"], params
    parse results.body
  end

  def parse results
    json = MultiJson.load results
    return_hash = {}
    movie = json["movies"][0]
    return_hash[:url] = "http://rottentomatoes.com/m/#{movie["id"]}"
    return_hash[:title] = movie["title"]
    return_hash[:year] = movie["year"]
    return_hash[:consensus] = movie["critics_consensus"]
    return_hash[:critics_rating] = movie["ratings"]["critics_rating"]
    return_hash[:critics_score] = movie["ratings"]["critics_score"]

    puts "### #{return_hash[:title]} (#{return_hash[:year]})"
    puts "#{return_hash[:critics_rating]} #{return_hash[:critics_score]}%"
    puts "#{return_hash[:consensus]}"

    return_hash
  rescue NoMethodError => e
    puts "Boo #{movie}"
    puts results
  end

end
