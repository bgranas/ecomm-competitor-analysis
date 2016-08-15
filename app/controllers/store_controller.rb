class StoreController < ApplicationController
  def index
  	@stores = Store.all
  end

  def new

  end

  def create
  	home_url = params[:home_url]
  	name = home_url.partition('.').last.partition('.').first
  	store = Store.new(name: name, home_url: home_url, ecomm_provider: params[:ecomm_provider])
  	redirect_to('import/index')
  end
end
