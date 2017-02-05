class DashboardController < ApplicationController
  def show
  	@client = Store.find_by_id(params[:id])
  	@competitors = Store.where(id: [2,3])
  	
  	@client_products = StoreProduct.where(store_id: @client.id)
  	#comp_products = StoreProduct.where.not(store_id: @client.id).group_by(&:store_id)
  	@sorted_products = StoreProduct.where.not(store_id: @client.id).group_by(&:product_id) 

  	#@comp_products = {}
  	#@competitors.each do |comp|
  	#	comp_store = Store.find(comp.competitor_id)
  	#	comp_prods = comp.store_products
  	#	@comp_products[comp.id] = comp_prods
  	#end
  end
end
