class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.date     :date
      t.integer  :how_do_you_feel
      t.text     :why
      t.text     :what_went_well
      t.integer  :user_id
      t.timestamps
    end
  end
end
