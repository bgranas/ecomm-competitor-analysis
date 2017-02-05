class StoreGroup < ActiveRecord::Base
	belongs_to :store
	belongs_to :group
end
