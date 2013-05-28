class Note < ActiveRecord::Base
  attr_accessible :evaluated_id, :note, :user_id, :content

  belongs_to :user
end
