# == Schema Information
#
# Table name: invitations
#
#  id              :integer          not null, primary key
#  invitor_id      :integer
#  invited_email   :string(255)
#  accepted        :boolean          default(FALSE)
#  invitation_code :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Invitation < ActiveRecord::Base
  attr_accessible :invited_email, :invitor_id

  belongs_to :user

  validates :invitor_id, uniqueness: { scope: :invited_email }
end
