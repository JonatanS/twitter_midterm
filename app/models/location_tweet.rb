class Location_Tweet

	attr_accessor :message, :latitute, :longitude, :num_retweets, :date_time, :image_url

	def initialize(msg, lat, lon, num_retweets, date_time, img_url)
		self.message = msg
		self.latitute = lat
		self.longitude = lon
		self.num_retweets = num_retweets
		self.date_time = date_time
		self.image_url = img_url
	end
end