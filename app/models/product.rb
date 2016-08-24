class Product < ActiveRecord::Base
	belongs_to :manufacturer


	def self.save_products
		raw_products = RawProduct.where(store_id: 1)

		evenheat = Manufacturer.find_by_name("Evenheat")
		jenken = Manufacturer.find_by_name("Jen-Ken")
		speedball = Manufacturer.find_by_name("Speedball")
		raw_products.each do |prod|
			#determine mfgr
			if prod.product_title.include? "Evenheat"
				manufacturer_id = evenheat.id
			elsif prod.product_title.include? "Jen-Ken"
				manufacturer_id = jenken.id
			elsif prod.product_title.include? "Speedball"
				manufacturer_id = speedball.id
			else
				manufacturer_id = nil
			end

			p = Product.find_or_create_by(manufacturer_id: manufacturer_id, title: prod.product_title)
			puts 'saving: ' + p.title.to_s
		end
	end
end
