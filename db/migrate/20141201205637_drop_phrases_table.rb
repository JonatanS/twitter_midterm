class DropPhrasesTable < ActiveRecord::Migration
  def change
  	drop_table :phrases
  end
end
