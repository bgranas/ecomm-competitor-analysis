class Store < ActiveRecord::Base
	store_accessor :stores
	has_many :competitors, :class_name => 'ClientCompetitor', :foreign_key => 'client_id'
	has_many :raw_products
	has_many :store_products
	has_one :store_scrape_term
	has_many :store_all_proucts_urls
end
