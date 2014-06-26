class MarkersController < ApplicationController
  before_action :set_marker, :only => [:show, :edit, :update, :destroy]
	respond_to :json, :html

  def index
    @markers = Marker.all
    respond_with @markers
  end
	
	def new
		@marker = Marker.new
	end

	def create
		@marker = Marker.new(marker_params)
		@course = Course.find(params[:marker][:course_id])
		@marker.course = @course

    if @marker.save
      respond_to do |format|
        format.html { redirect_to courses_path }
        format.json { render json: @marker, status: :created }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
	end

	def edit
		if @marker.update(marker_params)
      respond_to do |format|
        format.html { redirect_to courses_path }
        format.json { render nothing: true, status: :no_content }
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
	end

	def update
		if @marker.update(marker_params)
      respond_to do |format|
        format.html { redirect_to courses_path }
        format.json { render nothing: true, status: :no_content }
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
  	end
  end

	def destroy
		@marker.destroy
    respond_to do |format|
      format.html { redirect_to courses_path }
      format.json { render json: { head: :ok } }
		end
	end

  protected

  def set_marker
    @marker = Marker.find(params[:id])
  end

  def marker_params
    params.require(:marker).permit(:latitude, :longitude)
  end
end
