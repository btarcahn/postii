Rails.application.routes.draw do

  namespace :account_services do
    get 'login/create'
  end
  acc_svc_dir = 'account_services/'
  api_v1 = '/api/v1'

  scope '/auth' do
    get 'sign_up', to: "#{acc_svc_dir}registrations#new"
    get 'sign_up/exists', to: "#{acc_svc_dir}registrations#exists"
    post 'sign_up', to: "#{acc_svc_dir}registrations#create"
    get 'sign_in', to: "#{acc_svc_dir}login#new"
    post 'sign_in', to: "#{acc_svc_dir}login#create", as: 'log_in'
    delete 'logout', to: "#{acc_svc_dir}login#destroy"
    get 'password', to: "#{acc_svc_dir}passwords#edit", as: 'edit_password'
    patch 'password', to: "#{acc_svc_dir}passwords#update"
    get 'password/reset', to: "#{acc_svc_dir}password_resets#new"
    post 'password/reset', to: "#{acc_svc_dir}password_resets#create"
    get 'password/reset/edit', to: "#{acc_svc_dir}password_resets#edit"
    patch 'password/reset/edit', to: "#{acc_svc_dir}password_resets#update"
  end

  resources :err_msgs, path: "#{api_v1}err_msgs"
  resources :quests, path: "#{api_v1}quests"
  resources :creators, path: "#{api_v1}creators"
  resources :basic_posters, path: "#{api_v1}basic_posters"
  scope api_v1 do

    root "application#get_hello"

    get 'creators/:id/basic_posters', to: 'creators#index_basic_posters'
    get 'basic_posters/:id/quests', to: 'basic_posters#index_quests'
    post 'basic_posters/:id/quests', to: 'basic_posters#create_quest'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
