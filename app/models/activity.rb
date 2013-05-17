#encoding: utf-8
# == Schema Information
#
# Table name: activities
#
#  id              :integer          not null, primary key
#  activity_type   :string(255)
#  status          :string(255)
#  conversation_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  body            :text
#  date            :date
#

class Activity < ActiveRecord::Base
  attr_accessible :activity_type, :conversation_id, :status, :body, :date

  ACTIVITY_TYPE = {
    coffee: _('Tomar un café'),
    movie: _('Ir al cine / espectáculo'),
    drink: _('Salir de copas'),
    sport: _('Actividad deportiva'),
    culture: _('Actividad cultural'),
    heart: _('Conocerte de verdad')
  }

  validate :activity_type, presence: true

  belongs_to :conversation

  def accept!
    update_attribute(:status, :accepted)
  end

  def reject!
    update_attribute(:status, :rejected)
  end

  def rejected?
    status.to_sym == :rejected if status
  end

  def accepted?
    status.to_sym == :accepted if status
  end
end
