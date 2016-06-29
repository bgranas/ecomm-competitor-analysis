class JkPhoto < ActiveRecord::Base
	validates :photo_url, presence: true, :uniqueness => {:scope => :jk_product_id}

	belongs_to :jk_product
end
