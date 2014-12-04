class RenameCityColumnsAndChangeToFloat < ActiveRecord::Migration
  def change
  	rename_column :cities, :lat, :latitude
  	change_column :cities, :latitude, :float
  	rename_column :cities, :lon, :longitude
  	change_column :cities, :longitude, :float
  	rename_column :cities, :name, :address
  end
end
