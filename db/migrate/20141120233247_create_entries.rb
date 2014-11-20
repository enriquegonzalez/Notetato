class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :diary_id
      t.integer :question_id
      t.text :answer
      t.datetime :date

      t.timestamps
    end
  end
end
