class StaticPagesController < ApplicationController
  layout 'application_full_width', only: [:home]
  def home
    @spots = Spot.limit(4).order('created_at DESC')
    @reviews = Review.limit(10).order('created_at DESC')
    # @prefs = JpPrefecture::Prefecture.all
    @wp_path = ENV['WP_PATH']
    
    conn = Faraday.new(url: ENV['WP_PATH']) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = conn.get '/wp-json/wp/v2/posts?_embed'  

    @parsed_articles = JSON.parse(response.body)

  end

  def dbmap
  end
end
