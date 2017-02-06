class MatchController < ApplicationController
  require 'fuzzy_match'

  def show
  	store_id = params[:id]
    @client = RawProduct.where(store_id: store_id).where('product_title LIKE ?', "%AIM%")
    @all_products = Product.where(manufacturer_id: 2)

    @fuzzy = FuzzyMatch.new(@all_products, :read => :title, :stop_words => ["Evenheat","Jen-Ken", "AIM", "Kiln", "Glass", "Ceramic", "Knife", "Oven", "Porcelain/China", "Heat", "Treat", "Element"])


  end

 def match_products
  selected_products = []
  products = params[:match]
  store_id = params[:match][:store_id]
  selected_products = products.map{ |key,value| key if products[key] == "1"}.to_a.compact
  new_products = products.map{ |key,value| key if products[key] == "0"}.to_a.compact
#  selected_products.each_with_index do |p|
#    ref = p.split('_')[0]
#    match = p.split('_')[1]
#    raw_product = RawProduct.find_by_id(ref)
#    puts 'saving: ' + ref.to_s + ', ' + match.to_s
#    StoreProduct.create(store_id: store_id, product_id: match, url: raw_product.url, product_title: raw_product.product_title, sale_price: raw_product.sale_price, original_price: raw_product.original_price, stock: raw_product.stock, discount: raw_product.discount, shipping: raw_product.shipping)
#  end

  
  new_products.each do |p|
    ref = p.split('_')[0]
    raw_product = RawProduct.find_by_id(ref)
    new_product = Product.save_product(ref)
    StoreProduct.create(store_id: store_id, product_id: new_product.id, url: raw_product.url, product_title: raw_product.product_title, sale_price: raw_product.sale_price, original_price: raw_product.original_price, stock: raw_product.stock, discount: raw_product.discount, shipping: raw_product.shipping)
  end

  redirect_to('/store/show/' + store_id)
end
end
