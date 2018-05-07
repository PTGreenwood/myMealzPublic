Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/adminDB', as: 'rails_admin'

  #Dietitian Controller - dietitian_dashboard
  #get 'dietitian_dashboard/myClients'
  get 'dashboard/:id/dietitian/myClients' => 'dietitian_dashboard#myClients'
  #get 'dietitian_dashboard/dietitianProfile'
  get 'dashboard/:id/dietitian/profile' => 'dietitian_dashboard#dietitianProfile'
  #get 'dietitian_dashboard/contactSupport'
  get 'dashboard/:id/dietitian/support' => 'dietitian_dashboard#contactSupport'


  #Admin Ctonroller - admin_dashboard
  #get 'admin_dashboard_controller/support'
  get '/admin/ticketSupport' => 'admin_dashboard#support'
  #get 'admin_dashboard_controller/alterContent'
  get '/admin/alterContent' => 'admin_dashboard#alterContent'


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


  get 'showTickets', to: 'pages#showTickets'

  get 'admin_dashboard/replyMessage/:messageDetails', to: 'admin_dashboard#replyTicketMessage'
  get 'admin_dashboard/deleteTicket/bzOYrqMEphgnIb/:ticketID', to: 'admin_dashboard#deleteTicketWithID'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
