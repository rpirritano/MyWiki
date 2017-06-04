Rails.application.routes.draw do

devise_for :users

resources :wikis

resources :charges, only: [:new, :create]

post 'downgrade' => 'charges#downgrade'

get 'about' => 'welcome#about'

root 'welcome#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
