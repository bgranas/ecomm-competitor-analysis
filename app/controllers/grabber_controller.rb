class GrabberController < ApplicationController
  
  require 'fuzzy_match'
	#set SSL_CERT_FILE=C:\RailsInstaller\cacert.pem
  def index
  	@products = CompetitorPrice.all
  end

  def all_prices
    @sc = Product.where("id > ?", 75).where("id < ?", 235)
    @comp = Product.where("id > ?", 234) 

    @fuzzy = FuzzyMatch.new(@comp, :read => :title, :stop_words => ["Evenheat","Jen-Ken","Kiln", "Glass", "Ceramic", "Knife", "Oven", "Porcelain/China", "Heat", "Treat", "Element"])
   
    @matched = []
    prods = ProductMatch.all
    @matched = prods.map(&:reference_competitor_price)

  end

  def match_products
    selected_products = []
    products = params[:match]
    selected_products = products.map{ |key,value| key if products[key] == "1"}.to_a.compact
    puts selected_products.to_s
    selected_products.each_with_index do |p|
      ref = p.split('_')[0]
      match = p.split('_')[1]
      puts 'saving: ' + ref.to_s + ', ' + match.to_s
      ProductMatch.find_or_create_by(reference_competitor_price: ref, match_competitor_price: match)
    end
    redirect_to(:back)
  end

  def grab_products
  	competitor = Competitor.find_or_create_by(name: params[:competitor_price][:competitor])
  	
    manufacturer = Manufacturer.find_or_create_by(name: params[:competitor_price][:manufacturer])
  	url = params[:competitor_price][:url]

  	agent = Mechanize.new

  	index = agent.get(url)

  	product_container = index.search('.products-grid .item .product-image')
  	product_container.each do |prod|
  		prod_url = prod["href"].partition('.com').last
      prod_url = "http://usaknifemaker.com" + prod_url
      puts 'URL: ' + prod_url.to_s
  		product_page = agent.get(prod_url)

  		title = eval(competitor.competitor_scrape_term.title)
  		sale_price = eval(competitor.competitor_scrape_term.sale_price)
      #not always an original price
      if competitor.competitor_scrape_term.original_price && eval(competitor.competitor_scrape_term.original_price)
  		  original_price = eval(competitor.competitor_scrape_term.original_price)
      end
  		free_shipping = false

  		prod = Product.find_or_create_by(manufacturer_id: manufacturer.id, title: title)
  		prod_price = CompetitorPrice.find_or_create_by(product_id: prod.id, competitor_id: competitor.id, url: prod_url, sale_price: sale_price, original_price: original_price, free_shipping: free_shipping)

      #Only checking Shopify options for now
      if competitor.ecomm_platform == "Shopify"
    		options = product_page.search('select option')
    		options.each do |option|
    				title = eval(competitor.competitor_scrape_term.option_title)
            price = eval(competitor.competitor_scrape_term.option_price)
    				CompetitorPriceOption.find_or_create_by(competitor_price_id: prod_price.id, title: title, price: price)
    		end
      end
    end

    redirect_to action: 'index'
  end

  def save_scrape_terms
    competitor = Competitor.find_or_create_by(name: params[:terms][:competitor])
    title = params[:terms][:title_term]
    sale_price = params[:terms][:sale_price_term]
    original_price = params[:terms][:original_price_term]
    shipping = params[:terms][:shipping_term]
    stock = params[:terms][:sotck_term]
    discount = params[:terms][:discount_term]
    option_title = params[:terms][:option_title_term]
    option_price = params[:terms][:option_price_term]

    CompetitorScrapeTerm.find_or_create_by(competitor_id: competitor.id, title: title, sale_price: sale_price, original_price: original_price, free_shipping: shipping, stock: stock, discount: discount, option_title: option_title, option_price: option_price)
    redirect_to action: 'index'
  end
end
