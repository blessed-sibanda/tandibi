class Api::V1::PlacesController < ApplicationController
  def index
    keyword = params.fetch(:keyword)
    lat = params.fetch(:lat)
    lng = params.fetch(:lng)
    PlaceCrawlerJob.perform_later(keyword, lat, lng)
    render json: Place::Finder.call(keyword, lat, lng)
  end

  private

  def search_params
    params.require(:place).permit(:keyword, :lat, :lng)
  end
end
