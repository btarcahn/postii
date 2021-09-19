Rails.application.routes.draw do
  acc_svc_dir = 'account_services/'
  scope '/auth' do
    get 'sign_up', to: "#{acc_svc_dir}registrations#new"
    post 'sign_up', to: "#{acc_svc_dir}registrations#create"
    get 'sign_in', to: "#{acc_svc_dir}sessions#new"
    post 'sign_in', to: "#{acc_svc_dir}sessions#create", as: 'log_in'
    delete 'logout', to: "#{acc_svc_dir}sessions#destroy"
    get 'password', to: "#{acc_svc_dir}passwords#edit", as: 'edit_password'
    patch 'password', to: "#{acc_svc_dir}passwords#update"
    get 'password/reset', to: "#{acc_svc_dir}password_resets#new"
    post 'password/reset', to: "#{acc_svc_dir}password_resets#create"
    get 'password/reset/edit', to: "#{acc_svc_dir}password_resets#edit"
    patch 'password/reset/edit', to: "#{acc_svc_dir}password_resets#update"
  end
  scope '/api/v1' do
    resources :creators do
      get 'basic_posters/', to: 'creators#index_basic_posters'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
