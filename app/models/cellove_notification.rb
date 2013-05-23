# == Schema Information
#
# Table name: cellove_notifications
#
#  id              :integer          not null, primary key
#  sender_id       :integer
#  receiver_id     :integer
#  notifiable_id   :integer
#  notifiable_type :string(255)
#  seen            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CelloveNotification < ActiveRecord::Base
  attr_accessible :sender_id, :receiver_id, :notifiable_id, :notifiable_type

  NOTIFICATION_TYPE = {
    like: _('¡Le gusta!'),
    visit: _('¡Visitado!'),
    message: _('¡Nuevo mensaje!'),
    couple: _('¡Buena pareja!'),
    matchmaker: _('¡Nuevo celestino!')
  }

  belongs_to :notifiable, :polymorphic => true
end
