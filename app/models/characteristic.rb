class Characteristic < ActiveRecord::Base
	belongs_to :user

  attr_accessible :user_id, :creator_id, :romantic, :adventurer, :friendly, 
  	:familiar, :hardWorking, :extroverted, :generous, :reserved, :sociable, 
  	:quiet, :demanding, :prideful, :solitary, :tenacious, :attentive, :goodHumored, 
  	:spontaneous, :restless, :sensitive, :shy, :possessive, :jealous, :faithful
  
end
