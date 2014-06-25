class CoursesController < ApplicationController
	def index
		raise "Hello I'm here!"
	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.create(courseparams)
		redirect_to courses_path
	end

	protected

	def courseparams
		params.require(:course).permit(:name)
	end
end
