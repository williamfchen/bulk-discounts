Rails.application.routes.draw do
  get "/merchants/:merchant_id/dashboard", to: "merchants#show"
end
