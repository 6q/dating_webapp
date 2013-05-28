# == Schema Information
#
# Table name: notes
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  evaluated_id :integer
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Note < ActiveRecord::Base
  attr_accessible :evaluated_id, :note, :user_id, :content

  belongs_to :user
end
