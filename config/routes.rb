Rails.application.routes.draw do
  resources :bookmarks
  resources :tags
  resources :bookmark_stats
  resources :bookmark_stat_has_manifestations
end
