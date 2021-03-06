
Rails.application.routes.draw do
  resources :payments, only: [:connector, :new, :create]
  get 'payments/connector'
  get 'payments', to: 'payments#connector'
  get 'payments/new'
  get 'payments/create'

  #Stripe
  resources :charges
  get '/user_dashboard/getPaymentForm/', to: 'user_dashboard#displayPaymentForm'
  get '/user_dashboard/afterPaymentLoad', to: 'user_dashboard#afterPaymentLoad'

  mount RailsAdmin::Engine => '/adminDB', as: 'rails_admin'

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
  get '/showPlannedMeals', to: 'user_dashboard#showPlannedMeals'
  get '/showRecipeOptions', to: 'user_dashboard#showRecipeOptions'
  get '/getModelPrint', to: 'user_dashboard#getModelPrint'

  get 'user_dashboard/replyMessage/:messageDetails', to: 'user_dashboard#replyTicketMessage'
  get 'user_dashboard/getMessageHistory/:ticketID', to: 'user_dashboard#getMessageHistory'
  get '/user_dashboard/newTicket/:messageDetails', to: 'user_dashboard#newTicket'

  #Recipe options
  get '/user_dashboard/displayRecipeModel/:request', to: 'user_dashboard#displayRecipeModel'

  #myClientz - Contract linking
  get '/user_dashboard/doContract/:connection', to: 'user_dashboard#doContract'

  #Meal planner stuff
  get '/user_dashboard/getMealData/:request', to: 'user_dashboard#getMealData'
  get '/user_dashboard/saveMeal/:mealData' , to: 'user_dashboard#saveMealData'

  #Dietitian Controller - dietitian_dashboard
  get '/dietitian/ticketSupport' => 'dietitian_dashboard#support'
  get 'getMyClientz' => 'dietitian_dashboard#getMyClientz'
  get 'dietitian_dashboard/sendMail/:request', to: 'dietitian_dashboard#sendConnectionEmail'

  get 'user_dashboard/replyMessage/:messageDetails', to: 'user_dashboard#replyTicketMessage'
  get 'user_dashboard/getMessageHistory/:ticketID', to: 'user_dashboard#getMessageHistory'
  get '/user_dashboard/newTicket/:messageDetails', to: 'user_dashboard#newTicket'
  get 'dietitian_dashboard/updateContract/:contractDetails', to: 'dietitian_dashboard#updateContract'


  get 'showTickets', to: 'pages#showTickets'
  get 'profile', to: 'pages#showProfile'

  #User is general public
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }
  #devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  devise_scope :users do
    get 'users/login', to: 'devise/sessions#new'
    get 'login', to: 'pages#index'
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




  #Route on page not found
  get '*path', :controller => 'pages', :action => 'redirectOnFail'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
