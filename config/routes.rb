Rails.application.routes.draw do
  devise_for :admins

  #
  ## Admin routes
  #
  namespace :admin do
    resources :companies
    resources :coupons do
      collection do
        get(
          'import-coupons',
          to: 'coupons#import_coupons',
          as: :import_coupons
        )
        post(
          'create-import-coupons',
          to: 'coupons#create_import_coupons',
          as: :create_import_coupons
        )
      end
    end
    resources :company_coupons, path: 'company-coupons'
    resources :employees, only: [:index, :show, :destroy]
    get "/" => "home#index", as: :dashboard
  end

  #
  ## Global Routes
  #
  resources :employees, only: [:new, :create] do
    collection do
      get   'verify_employee_email'
      get   'email_is_valide'
      patch 'check_otp'
    end
  end

  root to: 'employees#new'
end
