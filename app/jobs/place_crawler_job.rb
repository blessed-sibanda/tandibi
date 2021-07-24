class PlaceCrawlerJob < ApplicationJob
  queue_as :default

  def perform(name, lat, lng)
    Place::Crawler.call(name, lat, lng)
  end
end
