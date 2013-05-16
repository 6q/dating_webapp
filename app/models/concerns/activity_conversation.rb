module ActivityConversation
  extend ActiveSupport::Concern

  included do
    has_one :activity
  end
end
