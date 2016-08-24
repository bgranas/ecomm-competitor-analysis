class ClientCompetitor < ActiveRecord::Base
	belongs_to :client, :class_name => 'Store'
	belongs_to :competitor, :class_name => 'Store'
end
