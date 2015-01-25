class MoviesController < ApplicationController
  def index
    render json: Movie.where(Movie.arel_table[:title].matches("%#{params[:term]}%"))
  end
end
