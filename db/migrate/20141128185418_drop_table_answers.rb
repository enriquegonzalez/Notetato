class DropTableAnswers < ActiveRecord::Migration
  def change
    drop_table :answers
  end
end
