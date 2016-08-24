class Store < ActiveRecord::Base
	store_accessor :stores
	has_many :competitors, :class_name => 'ClientCompetitor', :foreign_key => 'client_id'
end
