class StoreProduct < ActiveRecord::Base
	belongs_to :store

	def self.archive_store_product(store_id)
		prods = StoreProduct.where(store_id: store_id)
		prods.each do |prod|
			HistoricalStoreProduct.create(store_id: prod.store_id, product_id: prod.product_id, url: prod.url, product_title: prod.product_title, sale_price: prod.sale_price, original_price: prod.original_price, stock: prod.stock, discount: prod.discount, shipping: prod.shipping)
			prod.destroy
		end
	end

	def self.compare_historical
		cur_prod = StoreProduct.where(store_id: 2)

		cur_prod.each do |prod|
			hist_prod = HistoricalStoreProduct.find_by(product_id: prod.product_id)
			if prod.sale_price > hist_prod.sale_price
				puts prod.product_title.to_s + ' RAISED ' '| NEW: ' + prod.sale_price.to_s + ' | OLD: ' + hist_prod.sale_price.to_s
			elsif prod.sale_price < hist_prod.sale_price
				puts prod.product_title.to_s + ' LOWERED ' + '| NEW: ' + prod.sale_price.to_s + ' | OLD: ' + hist_prod.sale_price.to_s
			else
			end
		end
		puts 'COMPLETED'
	end

end
