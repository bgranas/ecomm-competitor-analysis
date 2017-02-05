class RawProduct < ActiveRecord::Base
	belongs_to :store

	def self.clear_raw_products
		prods = RawProduct.all
		prods.each do |prod|
			prod.destroy
		end
	end

	def match_to_store_product
		prod = HistoricalStoreProduct.find_by(store_id: self.store_id, url: self.url, product_title: self.product_title)
		if prod
			StoreProduct.find_or_create_by(store_id: self.store_id, product_id: prod.product_id, url: self.url, product_title: self.product_title, sale_price: self.sale_price, original_price: self.original_price, stock: self.stock, discount: self.discount, shipping: self.shipping)
		end
	end
end
