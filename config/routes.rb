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
    resources :project_tools, only: [:new, :edit, :create, :update]
    resources :activities, except: [:index, :show, :destroy]
    resources :documents, except: [:destroy]
    resources :todo_lists, except: [:destroy] do
      resources :todo_items, except: [:index, :destroy]
    end
  end

  get "/basecamp" => "documents#basecamp"
  get "/basecamp/edit" => "documents#basecamp_edit"

  %w( 404 422 500 503 ).each do |code|
    get code, :to => "static_pages#error", :code => code
  end
end
