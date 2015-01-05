class AddIndexToEntriesDate < ActiveRecord::Migration
  def change
    add_index :entries, [:user_id, :date], unique: true
  end
end
