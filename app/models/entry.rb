class Entry < ActiveRecord::Base
  belongs_to :diary
  belongs_to :question
end
