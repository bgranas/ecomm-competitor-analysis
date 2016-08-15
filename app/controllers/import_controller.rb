class ImportController < ApplicationController

  require 'fuzzy_match'
	#set SSL_CERT_FILE=C:\RailsInstaller\cacert.pem
  def index
  	
  end

  #Takes in a URL and just pulls in the URLs for each product on that page i.e. does't follow any links, just scrapes one page
  def import_product_urls
  	url = params[:raw_products][:all_products_url]
   	scrape_term = params[:raw_products][:scrape_term]

  	agent = Mechanize.new

  	page = agent.get(url)

  	@result = page.search(eval(scrape_term))

  	@result.each do |page|
  		RawProduct.create(store_id: 2, url: page.text)
  	end

  	redirect_to(:back)
  end

  def test_index_product_urls
  	url = params[:url]
  	scrape_term = params[:scrape_term]

  	agent = Mechanize.new

  	page = agent.get(url)

  	@result = page.search(eval(scrape_term))[1]

  	render partial: 'import/test_results' 

  end

  def test_product_page_url
  	url = params[:url]
  end



  #Calls multiple URLs and scrapes the product info off those pages
  def scrape_product_urls

  end


  def all_prices
    @sc = Product.where("id > ?", 75).where("id < ?", 235)
    @comp = Product.where("id < ?", 76) 

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
  	
    #manufacturer = Manufacturer.find_or_create_by(name: params[:competitor_price][:manufacturer])
  	#url = params[:competitor_price][:url]
    products = CompetitorPrice.where(competitor_id: competitor.id)
  	agent = Mechanize.new

  	products.each do |prod|
  		url = prod.url
      prod_url = "http://www.kilnfrog.com" + url
      puts 'URL: ' + prod_url.to_s
  		product_page = agent.get(prod_url)

  		title = eval(competitor.competitor_scrape_term.title)
  		sale_price = eval(competitor.competitor_scrape_term.sale_price)
      #not always an original price
      #if competitor.competitor_scrape_term.original_price && eval(competitor.competitor_scrape_term.original_price)
  		#  original_price = eval(competitor.competitor_scrape_term.original_price)
      #end
  		free_shipping = true

  		#prod = Product.find_or_create_by(manufacturer_id: manufacturer.id, title: title)
  		prod_price = CompetitorPrice.create(product_id: prod.id, competitor_id: competitor.id, url: prod_url, sale_price: sale_price, free_shipping: free_shipping)

      #Only checking Shopify options for now
      #if competitor.ecomm_platform == "Shopify"
      #	options = product_page.search('select option')
    	#	options.each do |option|
    	#			title = eval(competitor.competitor_scrape_term.option_title)
      #     price = eval(competitor.competitor_scrape_term.option_price)
    	#			CompetitorPriceOption.create(competitor_price_id: prod_price.id, title: title, price: price)
    	#	end
     
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
