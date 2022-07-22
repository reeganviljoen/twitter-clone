class CreateFollowedsAndFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :followeds_followers do |t|
      t.references :follower, foreign_key: {to_table: :users}, null: false
      t.references :followed, foreign_key: {to_table: :users}, null: false
    end
  end
end
