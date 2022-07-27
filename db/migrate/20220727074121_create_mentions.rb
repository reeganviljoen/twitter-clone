class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.references :tweet , null: true, foreighn_key: true
      t.references :user , null: true, foreighn_key: true
      t.timestamps
    end
  end
end
