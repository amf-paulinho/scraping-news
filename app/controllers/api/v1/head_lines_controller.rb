class Api::V1::HeadLinesController < ApplicationController
  def index
    headline = HeadLine.order(:scrape_date).all
    render json: headline
  end
end
