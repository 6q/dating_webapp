#encoding: utf-8
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
