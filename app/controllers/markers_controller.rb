class MarkersController < ApplicationController
	  before_action :set_marker, :only => [:show, :edit, :update, :destroy]
	
	def new
		@marker = Marker.new
	end

	def create
		@marker = Marker.new(marker_params)
		raise params.inspect

    if @marker.save
      respond_to do |format|
        format.html { redirect_to course_path }
        format.json { render json: @marker, status: :created }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
	end

    protected

  def set_marker
    @marker = Marker.find(params[:id])
  end

  def marker_params
    params.require(:marker).permit(:title, :lat, :lng)
  end
end
