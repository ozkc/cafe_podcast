# frozen_string_literal: true

class PodcastSearcher
  def self.call(query)
    url = "https://itunes.apple.com/search?term=#{query}&entity=podcast"
    response = HTTParty.get(url,
                            headers: { 'Accept': 'application/json' },
                            format: :json)
    return nil unless response.code == 200

    results = []
    response['results'].each do |r|
      result = { 'url': r['feedUrl'],
                 'media_url': r['artworkUrl600'],
                 'categories': r['genres'] }
      results << result
    end
    results
  end
end