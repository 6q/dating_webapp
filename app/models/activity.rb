class Activity < ActiveRecord::Base
  attr_accessible :activity_type, :conversation_id, :status, :body, :date

  ACTIVIY_TYPE = %w{cofee movie drink sport culture heart}

  validate :activity_type, presence: true

  belongs_to :conversation
end
