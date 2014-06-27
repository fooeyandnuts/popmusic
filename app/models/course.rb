class Course < ActiveRecord::Base
	has_many :markers
	validates_presence_of :name
end
