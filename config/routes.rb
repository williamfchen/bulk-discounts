Rails.application.routes.draw do
  get "/merchants/:merchant_id/dashboard", to: "merchants#show"
  get "/merchants/:merchant_id/items", to: "merchants/items#index"
  get "/merchants/:merchant_id/invoices", to: "merchants/invoices#index"
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchants/invoices#show", as: :merchant_invoice

  
  
  
  
  
  
  
  
  
  
  # namespace :merchant do
  #     resources :invoices, only: [:index, :show]
  #     resources :items, only: [:index]

  # end

  # resources :merchants, only: [:show]

  # resources :merchants, param: :merchant_id do
  #   get "dashboard", on: :member, to: "merchants#show_dashboard"
  #   resources :items, only: [:index]
  #   resources :invoices, only: [:index, :show]
  # end
end
