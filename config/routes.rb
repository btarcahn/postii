Rails.application.routes.draw do

  scope '/api/v1' do
    resources :err_msgs, :quests, :creators, :basic_posters
  end

  mount PostiiAPI => '/api'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
