class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, foreign_key: {to_table: :tweets}

      t.string :tweet_type, null: false, default:'tweet'
      t.timestamps
    end
  end
end
