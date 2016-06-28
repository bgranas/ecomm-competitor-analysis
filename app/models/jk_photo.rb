class JkPhoto < ActiveRecord::Base
	validates :photo_url, presence: true, :uniqueness => {:scope => :jk_product_id}
end
