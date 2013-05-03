require 'cellove/concerns/activity_conversation.rb'
Conversation.send(:include, Cellove::Concerns::ActivityConversation)
