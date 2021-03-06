Rails.application.routes.draw do

  devise_for :users
  scope "/admin" do
    resources :users, except: [:new, :create] do
      patch :approve, :on => :member
      patch :update_profile, :on => :member
    end
    resources :workers do
      post :request_config, :on => :member
    end
    resources :repositories do
      post :fetch_branches, :on => :member
      post :post_hook, :on => :member
    end
    resources :enviroments
    resources :base_versions
    resources :issue_trackers
    resources :home_page_contents, except: [:show]
    resources :tests_executors
  end
  get 'users/profile', as: 'user_root'
  
  resources :admin, only: [:index]
  resources :build_numbers, only: [:index, :show] do
    post :generate, :on => :collection
  end
  
  resources :enviroments, param: :title, path: "/", only: [] do
    resources :build_jobs, only: [:index, :show, :new, :create, :destroy] do
      delete :stop, :on => :member
      get :check_existing, :on => :collection
      resources :tests_results, only: [:index, :show]
    end
    resources :build_logs, only: [:show]
    resources :build_artefacts, only: [:show], :param => :filename, :filename => /.*/, :format => false
    resources :live_updates, only: [] do
      get :build_jobs, :on => :collection
    end
  end
  resources :dynamic_stylesheets, only: [:index]
  
  get '/:enviroment_title', to: 'build_jobs#enviroments', as: 'home_enviroments'

  root 'home#index'

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
end
