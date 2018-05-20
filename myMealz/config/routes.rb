Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/adminDB', as: 'rails_admin'

  #Dietitian Controller - dietitian_dashboard


  #Admin Controller - admin_dashboard
  get '/admin/ticketSupport' => 'admin_dashboard#support'
  get '/admin/alterContent' => 'admin_dashboard#alterContent'
  get 'admin_dashboard/replyMessage/:messageDetails', to: 'admin_dashboard#replyTicketMessage'
  get 'admin_dashboard/deleteTicket/:ticketID', to: 'admin_dashboard#deleteTicketWithID'
  get 'admin_dashboard/getMessageHistory/:ticketID', to: 'admin_dashboard#getMessageHistory'
  get 'admin_dashboard/resolveTicket/:ticketID', to: 'admin_dashboard#resolveTicket'

  #User Controller - user_dashboard
  get '/user/ticketSupport' => 'user_dashboard#support'
  get '/showMealPlanner', to: 'user_dashboard#showMealPlanner'
  get 'user_dashboard/replyMessage/:messageDetails', to: 'user_dashboard#replyTicketMessage'
  get 'user_dashboard/getMessageHistory/:ticketID', to: 'user_dashboard#getMessageHistory'
  get '/user_dashboard/newTicket/:messageDetails', to: 'user_dashboard#newTicket'

  #Meal planner stuff
  get '/user_dashboard/getMealData/:request', to: 'user_dashboard#getMealData'
  get '/user_dashboard/saveMeal/:mealData' , to: 'user_dashboard#saveMealData'

  #Dietitian Controller - dietitian_dashboard
  get '/dietitian/ticketSupport' => 'dietitian_dashboard#support'
  get 'getMyClientz' => 'dietitian_dashboard#getMyClientz'
  get 'user_dashboard/replyMessage/:messageDetails', to: 'user_dashboard#replyTicketMessage'
  get 'user_dashboard/getMessageHistory/:ticketID', to: 'user_dashboard#getMessageHistory'
  get '/user_dashboard/newTicket/:messageDetails', to: 'user_dashboard#newTicket'
  get 'dietitian_dashboard/updateContract/:contractDetails', to: 'dietitian_dashboard#updateContract'


  get 'showTickets', to: 'pages#showTickets'

  #User is general public
  #devise_for :users, path: 'users', controllers: { sessions: "devise/sessions" }
  #devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  #devise_scope :users do
    #get 'users/login', to: 'devise/sessions#new'
  #  get 'login', to: 'pages#index'
    #delete 'users/logout', to: 'devise/sessions#destroy'
  #end
  #
  #devise_for :users, skip: [:session], :controllers => {:registrations => "registrations2"}
  devise_for :users, skip: [:sessions]
  as :user do
    get 'signin', to: 'pages#index', as: :new_user_session
    post 'signin', to: 'pages#index', as: :user_session
    #get 'users', to: 'pages#index', as: :user_registration_path
    #post 'users', to: 'pages#index', as: :new_user_registration_path
    delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
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
