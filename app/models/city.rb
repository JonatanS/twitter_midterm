#http://railscasts.com/episodes/273-geocoder
class City < ActiveRecord::Base
	#attr_accessible :address, :latitude, :longitude
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	validates_uniqueness_of :address
end
