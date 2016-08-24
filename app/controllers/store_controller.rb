class StoreController < ApplicationController
  def index
  	@stores = Store.all
  end

  def new

  end

  def create
  	home_url = params[:store][:home_url]
  	name = home_url.split('www.')[1].split('.')[0]
  	store = Store.create(name: name, home_url: home_url, ecomm_platform: params[:ecomm_platform])

    product_title = params[:store][:product_title]
    sale_price = params[:store][:sale_price]
    original_price = params[:store][:original_price]
    shipping = params[:store][:shipping]
    stock = params[:store][:stock]
    discount = params[:store][:discount]
    option_title = params[:store][:option_title]
    option_price = params[:store][:option_price]

    StoreScrapeTerm.create(store_id: store.id, product_title: product_title, sale_price: sale_price, original_price: original_price, shipping: shipping, stock: stock, discount: discount, option_title: option_title, option_price: option_price)
  	redirect_to('/store/index')
  end

  def edit
  	@store = Store.find_by_id(params[:id])
  	@terms = StoreScrapeTerm.find_by_store_id(params[:id])
  	#@all_products_urls = StoreAllProductsUrl.find_by_id(@store.id)
  end

  def update
  	#if params[:store][:store_id]
  		store = Store.find_by_id(params[:store][:store_id])
  		store.update_attributes(home_url: params[:store][:home_url], ecomm_platform: params[:store][:ecomm_platform])
  	#end
  	#if params[:terms][:store_id]
  #		terms = StoreScrapeTerm.find_by_store_id(params[:terms][:store_id])
 # 	end
  #	if params[:store_all_products_url][:store_id]
 # 		all_products_urls = StoreAllProductsUrl.find_by_store_id(store.id)
  #		all_products_urls.update_attributes(all_product_url: params[:store_all_products_url][:store_all_products_url])
  #	end
  	
  	redirect_to('/store/index')
  end

  def save_scrape_terms
    store = Store.find_by_id(params[:terms][:store_id])
    all_products = params[:terms][:all_products]
    product_title = params[:terms][:product_title]
    sale_price = params[:terms][:sale_price]
    original_price = params[:terms][:original_price]
    shipping = params[:terms][:shipping]
    stock = params[:terms][:stock]
    discount = params[:terms][:discount]
    option_container = params[:terms][:option_container]
    option_title = params[:terms][:option_title]
    option_price = params[:terms][:option_price]

    terms = StoreScrapeTerm.find_by_store_id(store.id) 
    terms.update_attributes(store_id: store.id, all_products: all_products, product_title: product_title, sale_price: sale_price, original_price: original_price, shipping: shipping, stock: stock, discount: discount, option_container: option_container, option_title: option_title, option_price: option_price)
    redirect_to('/store/index')
  end

  def save_all_products_url
  	StoreAllProductsUrl.find_or_create_by(store_id: params[:store_all_products_url][:store_id], all_product_url: params[:store_all_products_url][:store_all_products_url])
  	redirect_to(:back)
  end
end
