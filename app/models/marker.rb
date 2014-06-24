class Marker < ActiveRecord::Base
	belongs_to :route
	has_one :song
end
