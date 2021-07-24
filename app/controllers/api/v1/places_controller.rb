class Api::V1::PlacesController < ApplicationController
  def index
    keyword = params.fetch(:keyword)
    lat = params.fetch(:lat)
    lng = params.fetch(:lng)
    Place::Crawler.new(keyword, lat: lat, lng: lng).call
    render json: Place::Finder.new(keyword, lat: lat, lng: lng).call
  end

  private

  def search_params
    params.require(:place).permit(:keyword, :lat, :lng)
  end
end
