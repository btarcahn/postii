Rails.application.routes.draw do

  devise_for :users, path: 'auth',
             path_names: {
               sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification',
               unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in'
             },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }


  scope '/api/v1' do
    resources :err_msgs, :quests, :creators, :basic_posters
  end

  mount PostiiAPI => '/api'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
