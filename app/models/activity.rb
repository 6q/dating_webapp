class Activity < ActiveRecord::Base
  attr_accessible :activity_type, :conversation_id, :status

  ACTIVIY_TYPE = %w{cofee movie drink sport culture heart}
end
