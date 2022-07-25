class CreateTagsTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tags_tweets, id: false do |t|
      t.belongs_to :tags
      t.belongs_to :tweets
    end
  end
end
