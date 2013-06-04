MovieInfo::Application.routes.draw do
  get "search/index"
  get "search/results"
  get "search/movie/:id" => 'search#movie'

  root :to => 'search#index'
end
