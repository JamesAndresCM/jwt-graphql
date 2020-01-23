Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   devise_for :users,
              defaults: {format: :json},
              path: '',
              path_names: {
                 sign_in: 'login',
                 sign_out: 'logout'
               },
               controllers: {
                 sessions: 'sessions'
               }
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'home' => 'home#index'
      get 'open_routes' => 'routes#index'
      get 'init_dispatches' => 'dispatches#dispatches'
      get 'current_user' => 'account_relationships#index'
    end
  end
end
