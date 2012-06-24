CatalogueOfHotels::Application.routes.draw do

  match 'about_as', :to => 'pages#about_us', :as => "about_as"
  match 'to_owners', :to => 'pages#to_owners', :as => "to_owners"
  match 'requisites', :to => 'pages#requisites', :as => "requisites"

  match "articles/images", :to => "articles/images#create_image", :via => [:post, :get]

  resources :messages, :only => %w{new create}

  resources :dynamic_models do
    resources :dynamic_fields do
       collection do
         get 'edit_order'
         put 'update_order'
       end
    end
  end

  resources :offers, :only => %w{index show} do
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

  resources :hotels  do
    resources :comments
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

  resources :articles, :shallow => true do
    resources :images, :controller=>"articles/images", :only => [:create, :destroy, :create_image] do
      collection do
        delete 'destroy'
      end
    end
  end

  resources :places, :shallow => true do
    collection do
      get "autocomplete_place_title"
      get "quick_search"
    end

    resources :maps, :controller=>"places/maps", :only=>[:create]
    resources :images, :controller=>"places/images", :only=>[:create, :destroy, :index, :update] do
      collection do
        put "update"
      end
    end
    resources :articles
  end

  resources :places do
    resources :comments
  end
  resources :comments


  namespace :admin do
    resources :hotels, :only=>[:index, :order] do
      collection do
        get :order
        post :update_order
        get :not_confirmed
      end
    end
    resource  :dashboard, :only=>[:show]
    resources :reserves
    resources :offer_agents
    resources :orders
    resources :offers do
      collection do
        post :update_order
      end

      resources :images, :controller => "offers/images", :only => %w{create destroy} do
        collection do
          delete 'destroy'
        end
      end
    end
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
