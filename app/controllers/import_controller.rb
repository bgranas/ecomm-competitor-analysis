class ImportController < ApplicationController

  
	#set SSL_CERT_FILE=C:\RailsInstaller\cacert.pem
  def index
  	
  end

  def view
  	@store = Store.find_by_id(params[:id])
  end

  #Takes in a URL and just pulls in the URLs for each product on that page i.e. does't follow any links, just scrapes one page
  def import_product_urls
  	store = Store.find_by_id(params[:id])
  	urls = StoreAllProductsUrl.where(store_id: store.id)
   	scrape_store = StoreScrapeTerm.find_by_store_id(store.id)
   	scrape_term = scrape_store.all_products

  	agent = Mechanize.new
  	urls.each do |url|
	  	page = agent.get(url.all_product_url)

	  	#scrape term must always be of form page.search('....')
	  	@result = eval(scrape_term)

	  	@result.each do |url|
	  		RawProduct.create(store_id: store.id, url: url["href"])
	  	end
	  end
  	redirect_to(:back)
  end

  def test_index_product_urls
  	store = Store.find_by_id(params[:id])
  	urls = StoreAllProductsUrl.where(store_id: store.id)
   	scrape_store = StoreScrapeTerm.find_by_store_id(store.id)
   	scrape_term = scrape_store.all_products
   	puts "*********term: " + scrape_term.to_s
   	@test_result = []
  	agent = Mechanize.new
  	urls.each do |url|
	  	page = agent.get(url.all_product_url)

	  	#scrape term must always be of form page.search('....')
	  	results = eval(scrape_term)
	  	results.each do |r|
	  		@test_result << r["href"]	
	  	end	
	  end
	  puts '*************result: ' + @test_result[0].to_s
  	redirect_to('/import/view/' + store.id.to_s) 

  end

  def test_product_page_url
  	url = params[:url]
  end



  #Calls multiple URLs and scrapes the product info off those pages
  def import_product_pages
  	store = Store.find_by_id(params[:id])
  	
    raw_prod = RawProduct.where(store_id: store.id)
    term = StoreScrapeTerm.find_by_store_id(store.id)
  	agent = Mechanize.new

  	raw_prod.each do |prod|
  		url = prod.url
      puts 'URL: ' + url.to_s
  		product_page = agent.get(url)

  		title = eval(term.product_title)
  		sale_price = eval(term.sale_price)

      #not always an original price
      original_price = ""
      if term.original_price && eval(term.original_price)
  		  original_price = eval(term.original_price)
      end
  		shipping = eval(term.shipping)
  		stock = eval(term.stock)

  		#prod = Product.find_or_create_by(manufacturer_id: manufacturer.id, title: title)
  		updated_product = prod.update_attributes(product_title: title, sale_price: sale_price, original_price: original_price, shipping: shipping, stock: stock)

      #Only checking Shopify options for now
      if term.option_container != ""
      	options = eval(term.option_container)
    		options.each do |option|
    			op_title = title + " " + eval(term.option_title)
          op_price = eval(term.option_price)
    			RawProduct.create(store_id: store.id, url: url, product_title: op_title, sale_price: op_price, shipping: shipping)
    		end
    	end
    end
    redirect_to(:back)
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
end
