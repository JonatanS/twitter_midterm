class CreateTwitterApps < ActiveRecord::Migration
  def change
    create_table :twitter_apps do |t|

      t.timestamps
    end
  end
end
