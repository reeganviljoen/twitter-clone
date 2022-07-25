class CreateTaggings < ActiveRecord::Migration[7.0]
  def change
    create_table :taggings do |t|
      t.references :user, null: true, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.references :tweet, null: true, foreighn_key: true
      t.timestamps
    end
  end
end


