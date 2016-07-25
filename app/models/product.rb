class Product < ActiveRecord::Base
	has_many :competitor_prices
	belongs_to :manufacturer
end
