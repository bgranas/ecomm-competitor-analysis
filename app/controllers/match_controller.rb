class MatchController < ApplicationController
  require 'fuzzy_match'

  def index
    @client = RawProduct.where(store_id: 3)
    @competitor = Product.all 

    @fuzzy = FuzzyMatch.new(@competitor, :read => :title, :stop_words => ["Evenheat","Jen-Ken","Kiln", "Glass", "Ceramic", "Knife", "Oven", "Porcelain/China", "Heat", "Treat", "Element"])


  end
end
