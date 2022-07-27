class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.references :sender , null: true, foreighn_key: { to_table: :users }
      t.references :notified , null: true, foreighn_key: { to_table: :users }
      t.timestamps
    end
  end
end
