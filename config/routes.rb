CatalogueOfHotels::Application.routes.draw do
  resources :dynamic_models do
    resources :dynamic_fields do
       collection do
         get 'edit_order'
         put 'update_order'
       end
    end
  end

  resources :hotels  do
    resources :images, :controller=>"hotels/images", :only=>[:new, :create, :destroy, :index, :update] do
      collection do
        delete 'destroy'
      end
    end

    resources :maps, :controller=>"hotels/maps", :only=>[:new, :index, :create]

    resources :rooms do
      member do
        delete 'delete_image'
      end
    end

    resource :confirm, :controller=>"hotels/confirms", :only=>[:edit, :update]
  end

  resources :reserves, :only=>[:index]  
  resources :rooms, :only=>[:index] do
    resources :reserves do

      member do
        get 'publish'
        get 'change_status'
      end

      collection do
        post 'calculate'
        put 'calculate'
      end

    end
  end

  resources :places, :shallow => true do
    resources :maps, :controller=>"places/maps", :only=>[:create]
    resources :images, :controller=>"places/images", :only=>[:create, :destroy, :index, :update] do
      collection do
        put "update"
      end
    end
  end

  namespace :admin do
    resources :hotels, :only=>[:index]
    resource  :dashboard, :only=>[:show]
    resources :reserves
  end

  namespace :my do
    resources :hotels, :only=>[:index]
  end

  root :to => "home#index"

  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
