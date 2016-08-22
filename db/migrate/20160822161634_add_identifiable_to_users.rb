class AddIdentifiableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :identifiable_id, :string
    add_column :users, :identified, :boolean
  end
end
