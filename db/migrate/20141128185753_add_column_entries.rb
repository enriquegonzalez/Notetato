class AddColumnEntries < ActiveRecord::Migration
  def change
    add_column :entries, :how_do_you_feel,       :integer
    add_column :entries, :what_went_well,        :text
    add_column :entries, :what_didnt_go_well,    :text
    add_column :entries, :how_to_make_it_better, :text
    add_column :entries, :focus_on_tomorrow,     :text
    add_column :entries, :how_do_you_feel_now,   :integer
    add_column :entries, :user_id,               :integer
  end
end
