Rails.application.routes.draw do
  devise_for :users,  controllers: { registrations: 'registrations', confirmations: 'confirmations',
                                    :omniauth_callbacks => "users/omniauth_callbacks"  } # Adding Devise custom fields, confirmable, omniauth
  root 'static_pages#home'
  get  'static_pages/home'
  get  'reservations', to: 'reservations#reservations', as: 'reservations'
  get  'trips', to: 'reservations#trips', as: 'trips'
  get  'reviews', to: 'reviews#create', as: 'reviews'

  resources :users do
    member do
      get :hosting, :guests
    end
  end

  resources :properties do
    member do
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photos'
      get 'amenities'
      get 'location'
    end
    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:create]
  end

  resources :reservations, only: [:create] do
    resources :reviews, only: [:create, :destroy]
  end
end
