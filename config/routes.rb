Rails.application.routes.draw do
  devise_for :users,  controllers: { registrations: 'registrations', confirmations: 'confirmations' } # Adding Devise custom fields and confirmable
  root 'static_pages#home'
  get  'static_pages/home'

  resources :users
end
