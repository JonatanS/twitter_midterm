class RemoveStringColumnFromLocationTweet < ActiveRecord::Migration
  def change
    remove_column :location_tweets, :string, :string
  end
end
