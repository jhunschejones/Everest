Rails.application.routes.draw do
  root to: "projects#index"

  controller :sessions do
    get "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end

  resources :documents, only: [:index]
  resources :activities, only: [:index]

  resources :projects, except: [:destroy] do
    resources :activities, except: [:index, :show, :destroy]
    resources :documents, except: [:destroy]
  end

  get "/application" => "documents#application"
end
