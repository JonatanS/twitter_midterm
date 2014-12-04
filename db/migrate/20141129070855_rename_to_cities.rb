class RenameToCities < ActiveRecord::Migration
  def change
  	rename_table :locations, :cities
  end
end
