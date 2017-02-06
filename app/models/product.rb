class Product < ActiveRecord::Base
	belongs_to :manufacturer

	def self.save_store_products
		raw_products = RawProduct.where(store_id: 1)

		raw_products.each do |raw_product|
			product = Product.find_by_title(raw_product.product_title)
			StoreProduct.create(store_id: 1, product_id: product.id, url: raw_product.url, product_title: raw_product.product_title, sale_price: raw_product.sale_price, original_price: raw_product.original_price, stock: raw_product.stock, discount: raw_product.discount, shipping: raw_product.shipping)
		end
	end

	def self.save_products
		raw_products = RawProduct.where(store_id: 1)

		evenheat = Manufacturer.find_by_name("Evenheat")
		jenken = Manufacturer.find_by_name("Jen-Ken")
		speedball = Manufacturer.find_by_name("Speedball")
		aim = Manufacturer.find_by_name("AIM")
		raw_products.each do |prod|
			#determine mfgr
			if prod.product_title.include? "Evenheat"
				manufacturer_id = evenheat.id
			elsif prod.product_title.include? "Jen-Ken"
				manufacturer_id = jenken.id
			elsif prod.product_title.include? "Speedball"
				manufacturer_id = speedball.id
			elsif prod.product_title.include? "AIM"
				manufacturer_id = aim.id
			else
				manufacturer_id = nil
			end

			p = Product.find_or_create_by(manufacturer_id: manufacturer_id, title: prod.product_title)
			puts 'saving: ' + p.title.to_s
		end
	end

	def self.save_product(raw_product_id)
		raw_product = RawProduct.find_by_id(raw_product_id)
		evenheat = Manufacturer.find_by_name("Evenheat")
		jenken = Manufacturer.find_by_name("Jen-Ken")
		speedball = Manufacturer.find_by_name("Speedball")
		#determine mfgr
		if raw_product.product_title.include? "Evenheat"
			manufacturer_id = evenheat.id
		elsif raw_product.product_title.include? "Jen-Ken"
			manufacturer_id = jenken.id
		elsif raw_product.product_title.include? "Speedball"
			manufacturer_id = speedball.id
		else
			manufacturer_id = nil
		end
		p = Product.find_or_create_by(manufacturer_id: manufacturer_id, title: raw_product.product_title)
		return p
	end
end
