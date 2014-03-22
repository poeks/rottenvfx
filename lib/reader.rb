class Reader

  def initialize file = nil
    @file = file || './movies.yml'
    @movies = []
  end

  def load
    File.foreach(@file) do |line|
      @movies << line.chomp
    end

    @movies
  end

end
