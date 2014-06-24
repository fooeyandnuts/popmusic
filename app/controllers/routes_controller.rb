class RoutesController < ApplicationController
	def index
	end

	def create
		@route = Route.new
	end

	
end
