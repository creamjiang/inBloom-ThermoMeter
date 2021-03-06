SlcSample2::Application.routes.draw do
  resources :klasses, :only => :index
  resources :students, :only => :index

  resource :alert, :only => [] do
    get 'sendit'
  end

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/failure", to: "sessions#failure"
  match "/auth/slc", :as => :login
  root to: "klasses#index"

end
