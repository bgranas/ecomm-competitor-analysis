Rails.application.routes.draw do
  get 'store/index'
  get 'store/new'
  match 'store/create' => 'store#create', via: [:post], as: 'create_store'

  get 'dashboard/index'

  get 'match/index'

  get 'import/index'
  match 'import/test_index_product_urls' => 'import#test_index_product_urls', via: [:post], as: 'test_index_product_urls'
  match 'import/test_product_page_url' => 'import#test_product_page_url', via: [:post], as: 'test_product_page_url'
  match 'import/import_product_urls' => 'import#import_product_urls', via: [:post], as: 'import_product_urls'
  match 'import/scrape_product_urls' => 'import#scrape_product_urls', via: [:post], as: 'scrape_product_urls'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  get 'jk_products/index' => 'jk_products#index'
end
