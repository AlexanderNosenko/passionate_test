Rails.application.routes.draw do
  scope path: :api, defaults: { format: :json } do
    resources :verticals, except: [:new, :edit]
    resources :categories, except: [:new, :edit]
  end
end
