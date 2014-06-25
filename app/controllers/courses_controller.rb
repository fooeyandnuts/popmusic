class CoursesController < ApplicationController
	before_action :setcourse, only: [:show]

	def index
		@courses = Course.all
	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.create(courseparams)
		redirect_to courses_path
	end

	def show
		@markers = Course.find(params[:id]).markers
	end

	def add_markers
		raise params.inspect
	end

	protected

	def courseparams
		params.require(:course).permit(:name)
	end

	def setcourse
		@course = Course.find(params[:id])
	end
end
