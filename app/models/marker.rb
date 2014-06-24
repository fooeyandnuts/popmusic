class Marker < ActiveRecord::Base
	belongs_to :course
	has_one :song
end
