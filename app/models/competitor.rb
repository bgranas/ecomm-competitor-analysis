class Competitor < ActiveRecord::Base
	has_many :competitor_prices
	has_one :competitor_scrape_term
	#Find ecommerce solution
	##Shopify has Shopify CDN links in the site head 
	##WooCommerce (WordPress)
	##Magento
	##squarespace



	#Find all products
	##First check sitemap.xml
	def get_product_urls
		agent = Mechanize.new
		#url = self.all_products_url
		#page = agent.get(url)

		url = "https://kilnfrog.com/collections/jen-ken"
		page = agent.get(url)


		#product_urls = page.search('url loc')
		#product_urls.each do |prod_url|
		#	prod_page = agent.get(prod_url)

		#	if prod_page.search('.description').text.include? 'Jen-Ken'
		#		mfgr = 'Jen-Ken'
		#	elsif prod_page.search('.description').text.include? 'Evenheat'
		#		mfgr = 'Evenheat'
		#	end

			#if competitor mfgr = Shopify
			##options = prod_page.search('#add-item-form .selector-wrapper')
			##options.each do |option|
			###option_label = option.search('label').text
			###choices = option.search('.option')
			###choices.each do |choice|
			####option_description = choice.search('option')



		end



		#For brand, search '.product_body clearfix'
		#For stock, can check schema for itemprop="availability"
end
