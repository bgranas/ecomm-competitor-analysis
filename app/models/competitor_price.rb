class CompetitorPrice < ActiveRecord::Base
	belongs_to :competitor
	belongs_to :product
	has_many :competitor_price_options
	has_many :product_matches, foreign_key: 'reference_competitor_price'
	has_many :product_matches, foreign_key: 'match_competitor_price'
end
