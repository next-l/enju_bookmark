Rails.application.routes.draw do
  resources :bookmarks
  resources :tags
  resources :bookmark_stats
end
