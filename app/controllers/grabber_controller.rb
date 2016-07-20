class GrabberController < ApplicationController
  
	#set SSL_CERT_FILE=C:\RailsInstaller\cacert.pem
  def index
  	@products = CompetitorPrice.all
  end

  def grab_products
  	competitor = Competitor.find_or_create_by(name: params[:competitor], ecomm_platform: params[:ecomm_platform])
  	manufacturer = Manufacturer.find_or_create_by(name: params[:manufacturer])
  	url = params[:url]

  	agent = Mechanize.new

  	index = agent.get(url)

  	product_container = index.search('#content-table .product')
  	product_container.each do |prod|
  		prod_url = prod.search('.image a')[0]["href"]
  		product_page = agent.get('https://kilnfrog.com' + prod_url)

  		title = product_page.search('#product .title').text
  		sale_price = product_page.search('#price-preview').text
  		original_price = product_page.search('#price-preview span').text
  		free_shipping = true

  		prod = Product.find_or_create_by(manufacturer: manufacturer, title: title)
  		prod_price = CompetitorPrice.create(product_id: prod.id, competitor_id: competitor.id, url: prod_url, sale_price: sale_price, original_price: original_price, free_shipping: free_shipping)

  		options = product_page.search('#add-item-form .selector-wrapper')
  		options.each do |option|
  			header = option.search('label').text
  			option_titles = option.search('option')

  			option_titles.each do |op_title|
  				title = op_title.text
  				CompetitorPriceOption.find_or_create_by(header: header, title: title)
  			end
  		end


  end
end
