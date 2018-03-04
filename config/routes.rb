Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  resources :articles do # dzięki odpowiedniej konwencji nazewniczej kontroller wie do jakiedo zasobu się odnieść
    post :add_like, on: :member
  # resources :articles, only: [:show] # jeśli chcemy by był dostęp tylko do metody show ale nie wyświetli się na stronie w tym wypadkubo nie ma create itd.
    resources :comments, only: [:create, :destroy]
  end
#do akcji które są zasobami nie trzeba pisać takich ścieżek jak poniżej wystarczy resources :articles
  # get 'articles', to: 'articles#index'
  # get 'articles/new', to: 'articles#new', as: 'new_article'
  # post 'articles', to: 'articles#create'
  # get 'articles/:id', to: 'articles#show', as: 'article'
  # delete 'articles/:id', to: 'articles#destroy'
  # get 'articles/:id/edit', to: 'articles#edit', as: 'edit_article'
  # patch 'articles/:id', to: 'articles#update'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# resources :articles do
# 	get 'generate_desctiption'
# end
# definiowanie dodatkowych adresów które są na tym zasobie
