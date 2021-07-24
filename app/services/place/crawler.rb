class Place::Crawler < ApplicationService
  attr_reader :keyword, :lat, :lng
  private :keyword, :lat, :lng

  CLIENT_ID = Rails.application.credentials.dig(
    :foursquare, :client_id
  )

  CLIENT_SECRET = Rails.application.credentials.dig(
    :foursquare, :client_secret
  )

  ENDPOINT = "https://api.foursquare.com/v2/venues/search"

  def initialize(keyword, lat:, lng:)
    @keyword = keyword
    @lat = lat
    @lng = lng
  end

  def call
    crawled_places&.each do |place_data|
      lat = place_data["location"]["lat"]
      lng = place_data["location"]["lng"]
      next if exists?("en", lng, lat)
      if place_data["categories"].empty?
        place_type = nil
      else
        place_type = place_data["categories"][0]["shortName"]
      end
      Place.create!(name: place_data["name"], coordinate: geo.point(lng, lat), locale: "en", place_type: place_type)
    end
  rescue Faraday::ConnectionFailed => e
    #  actually we should report this error
    # to a centralized error notification service
    puts "Faraday Connection Failed"
    puts e.message
  end

  private

  def connection
    @connection ||= Faraday.new(
      ENDPOINT,
      request: {
        timeout: 5.seconds,
      },
    )
  end

  def crawled_places
    @crawled_places ||= begin
        response = connection.get ENDPOINT do |req|
          req.params["query"] = keyword
          req.params["radius"] = 5_000
          req.params["ll"] = "#{lat},#{lng}"
          req.params["client_id"] = CLIENT_ID
          req.params["client_secret"] = CLIENT_SECRET
          req.params["v"] = "20180323"
        end
        response = JSON.parse(response.body)
        response["response"]["venues"]
      end
  end

  def geo
    @geo ||= RGeo::Geographic::Factory.new(
      "Spherical",
      has_z_coordinate: true,
      srid: 4326,
    )
  end

  def exists?(locale, lng, lat)
    point = geo.point(lng, lat)
    place = Place.where(
      coordinate: point,
      locale: "en",
    ).exists?
  end
end
