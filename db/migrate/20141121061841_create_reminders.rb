class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.integer :user_id
      t.boolean :by_phone
      t.boolean :by_email
      t.time :time

      t.timestamps
    end
  end
end
