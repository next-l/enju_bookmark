Rails.application.routes.draw do
  resources :users do
    resources :bookmarks, :only => :index
  end
  resources :bookmarks
  resources :tags
  resources :bookmark_stats
  resources :bookmark_stat_has_manifestations
end
