require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  mount Sidekiq::Web => '/sidekiq'

  # Defines the root path route ("/")
  # root "account_block/accounts#index"
  root "task_block/tasks#pending_tasks"

  namespace :account_block do
    resources :accounts
    resources :logins do 
      collection do
        get :end_session
      end
    end
  end
  namespace :task_block do
    resources :tasks do
      collection do
        get :trashed_tasks
        get :pending_tasks
        get :completed_tasks
        get :today_tasks
        get :upcoming_tasks
        # patch :bulk_update_task
        patch :update_task
        get :notification
      end
      patch :restore_task, on: :member
      delete :permanent_destroy, on: :member
    end
  end
end
