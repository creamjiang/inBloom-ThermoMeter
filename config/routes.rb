SlcSample2::Application.routes.draw do
  resources :klasses, :only => :index
  resources :students, :only => :index

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  root to: "klasses#index"
end
