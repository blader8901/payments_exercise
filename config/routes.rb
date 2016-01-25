Rails.application.routes.draw do
  resources :loans, only: [:index, :show], defaults: {format: :json} do
    resources :payments, only: [:index, :show, :create], defaults: {format: :json}
  end

  resources :payments, only: :show, defaults: {format: :json}
end
