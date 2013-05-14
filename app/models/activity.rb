class Activity < ActiveRecord::Base
  attr_accessible :activity_type, :conversation_id, :status, :body, :date

  ACTIVIY_TYPE = %w{cofee movie drink sport culture heart}

  validate :activity_type, presence: true

  belongs_to :conversation

  def accept!
    update_attribute(:status, :accepted)
  end

  def reject!
    update_attribute(:status, :rejected)
  end

  def rejected?
    status.to_sym == :rejected
  end

  def accepted?
    status.to_sym == :accepted
  end
end
