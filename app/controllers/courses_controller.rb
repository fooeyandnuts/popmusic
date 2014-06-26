class CoursesController < ApplicationController
	before_action :set_course, only: [:show, :edit, :update, :destroy]

	def index
		@courses = Course.all
	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.create(course_params)
		redirect_to courses_path
	end

	def show
		@markers = Course.find(params[:id]).markers
	end

	def update
		@marker = Marker.new(marker_params)
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

	def destroy
		@course.destroy
		respond_to do |format|
      format.html { redirect_to courses_path }
      format.json { render json: { head: :ok } }
    end
  end

	protected

	def course_params
		params.require(:course).permit(:name)
	end

	def set_course
		@course = Course.find(params[:id])
	end
end
