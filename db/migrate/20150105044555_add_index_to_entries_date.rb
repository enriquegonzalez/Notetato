class AddIndexToEntriesDate < ActiveRecord::Migration
  def change
    add_index :entries, :date, unique: true
  end
end
