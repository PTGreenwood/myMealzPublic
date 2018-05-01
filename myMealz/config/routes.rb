Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  #Client is Dietiian
  #devise_for :clients, path: 'clients', controllers: { sessions: "clients/sessions" } #e.g. /clients/sign_in
  #devise_scope :clients do
  #  get 'clients/sign_in', to: 'clients/sessions#new'
  #  get 'clients/sign_up', to: 'clients/sessions#create'
  #  delete 'clients/logout', to: 'clients/sessions#destroy'
  #  get 'clients/index', to: 'pages#home'
  #end


  #User is general public
  devise_for :users, path: 'users', controllers: { sessions: "devise/sessions" }
  devise_scope :users do
    get 'users/login', to: 'devise/sessions#new'
    delete 'users/logout', to: 'devise/sessions#destroy'
  end

  #Define route URL
  # '#' is refferring to a method
  root 'pages#index'

  #Define Routes for Pages (Controller)
  # '/' is referring to a page
  #Doing it this way allows the webaddress to not resemble the file structure on the server
  get '/home' => 'pages#home' #=> overrides default route
  get '/dashboard/:id' => 'pages#dashboard'
  get '/explore' => 'pages#explore'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
