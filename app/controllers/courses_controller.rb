class CoursesController < ApplicationController
	before_action :set_course, only: [:show, :edit, :update, :destroy]

	respond_to :json, :html

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
		respond_to do |format|
    	format.html
      format.json { render json: @markers, status: :created }
    end
	end

	def edit
	end

	def update
    if @course.update(course_params)
      respond_to do |format|
        format.html { redirect_to courses_path }
        format.json { render nothing: true, status: :no_content }
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
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
