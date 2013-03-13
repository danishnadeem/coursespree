Findtutor::Application.routes.draw do
  
  resources :availabilities

  resources :subadmins do
    collection do
      get "generate_free_code"
    end
  end

  resources :departments

  #  resources :admin do
  #    member do
  #      get :search_payments_transactions
  #    end
  #  end

  resources :users do
    collection do
      get 'fetch_departments'
    end
  end


  resources :tutor_locations
  resources :universities

  get 'meetings/joinmeeting'
  get 'meetings/createmeeting'
  post 'meetings/ipn_notification'
  get 'meetings/ipn_notification'
  get 'meetings/canceled_payment_request'
  get 'meetings/completed_payment_request'
  post 'meetings/payment'
  get 'meetings/payment_made'
  post 'tutors/addtutor'
  get 'tutors/addtutor'
  get 'tutors/mgmt'
  get 'tutors/approve'
  get 'subjects_tutors/select'
  
  resources :superadmins
  
  resources :tutor_availabilities
  resources :subjects_tutors

  resources :subjects

  get "admin/login"
  post "admin/login"
  get "admin/logout"

  resources :tutors
  

  resources :meetings do
    collection do
      get 'new_meeting'
      get 'end_meeting'
      post 'create_meeting'
    end
  end

  resources :journals do
    collection do
      get 'add_video_to'
    end
  end

  match 'register' => 'users#register'

  match '/payment_transaction' => 'admin#show_payments_transactions'
  match '/admins/search_payments_transactions' => "admin#search_payments_transactions"

  match '/student_report' => 'admin#show_student_meetings_reports'
  match '/admins/search_student_meetings_reports' => "admin#search_student_meetings_reports"

  match '/tutor_report' => 'admin#show_tutor_meetings_reports'
  match '/admins/search_tutor_meetings_reports' => "admin#search_tutor_meetings_reports"

  match '/meetings/completed_payment' => 'meetings#completed_payment'
  match '/meetings/cancelled_payment' => 'meetings#cancelled_payment'

  match "auth/:provider/callback" => "admin#oauth"

  match "/search_users" => "users#index"

  match "/tutors/mgmt" => "tutors#mgmt"


  #match urls for sending emails

  match '/reminder_email_before_twelve_hours' => 'cronjobs#reminder_email_before_twelve_hours'
  match '/reminder_email_before_six_hours' => 'cronjobs#reminder_email_before_six_hours'
  match '/reminder_email_before_two_hours' => 'cronjobs#reminder_email_before_two_hours'
  match '/reminder_email_when_meeting_starts' => 'cronjobs#reminder_email_when_meeting_starts'
  match '/reminder_email_when_meeting_ends' => 'cronjobs#reminder_email_when_meeting_ends'

  #match 'users/:id/register' => 'users#register'
  #
  #
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  root :to => 'pages#index'

  match "/about"=>"pages#about"
  match "/faq"=>"pages#faq"
  match "/comingsoon"=>"pages#comingsoon"
  match "/gettingstarted"=>"pages#gettingstarted"
  match "/howtouse"=>"pages#howtouse"
  match "/contact"=>"pages#contact"
  match "/pricing"=>"pages#pricing"
  match "/team"=>"pages#team"
  match "/press"=>"pages#press"
  match "/tos"=>"pages#terms_and_conditions"
  match "edit_user" => "users#edit"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  
end
