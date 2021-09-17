Rails.application.routes.draw do
  scope '/api/v1' do
    resources :creators do
      get 'basic_posters/', to: 'creators#index_basic_posters'
    end
    resources :basic_posters, only: [:create, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
