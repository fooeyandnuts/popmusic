class Marker < ActiveRecord::Base
  belongs_to :course
  has_many :songs
end
