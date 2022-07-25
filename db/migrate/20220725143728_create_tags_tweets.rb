class CreateTagsTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tagings do |t|
      t.belongs_to :tags
      t.belongs_to :tweets
      t.timestamps
    end
  end
end

