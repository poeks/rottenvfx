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
    movie = json["movies"][0]
    title = movie["title"]
    year = movie["year"]
    consensus = movie["critics_consensus"]
    critics_rating = movie["ratings"]["critics_rating"]
    critics_score = movie["ratings"]["critics_score"]

    puts "### #{title} (#{year})"
    puts "#{critics_rating} #{critics_score}%"
    puts "#{consensus}"
    puts

    [title, year, consensus, critics_rating, critics_score]
  rescue NoMethodError => e
    puts "Boo #{movie}"
    puts results
  end

end
