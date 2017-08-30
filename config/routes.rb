Rails.application.routes.draw do
  root to: 'groups#index'
  resources :groups do
    get '/changes/:date', :to => 'changes#index', :as => 'changes'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
