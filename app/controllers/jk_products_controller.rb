class JkProductsController < ApplicationController
	
	def index
		@products = JkProduct.all
	end
end
