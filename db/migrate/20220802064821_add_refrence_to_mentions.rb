class AddRefrenceToMentions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :mentions, :user
    add_column :mentions, :user_name, :string
    add_index :users, :handle, unique: true
  end
end
