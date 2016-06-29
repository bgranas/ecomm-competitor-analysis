class JkProduct < ActiveRecord::Base
	validates :url, presence: true, uniqueness: true
	validates :title, :uniqueness => {:scope => :url}

	has_many :jk_photos

	def self.get_urls
		agent = Mechanize.new

		page_count = 1
		
		while page_count <= 4
			link = "http://jenkenkilns.com/kilns.aspx?page=#{page_count}"
			page = agent.get(link)
			products = page.search('.product-list-item h5 a')
			products.each do |prod|
				title = prod.text
				url = prod["href"]
				JkProduct.find_or_create_by(title: title, url: url)
			end

			page_count = page_count + 1
		end
	end

	def self.get_prod_details
		agent = Mechanize.new

		products = JkProduct.all.where(price: nil).order('id ASC')
		products.each do |prod|
			page = agent.get("http://jenkenkilns.com/#{prod.url}")

			price = page.search('.prod-detail-cost-value').text.partition('$').last.gsub(',','')
			description = page.search('.prod-detail-desc').text

			prod.update_attributes(price: price, description: description)

			photos = page.search('.prod-detail-lt a')
			photos.each do |photo|
				url = photo["href"]
				JkPhoto.create(jk_product_id: prod.id, photo_url: url)
			end
		end
	end
end
