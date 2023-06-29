Rails.application.routes.draw do
  root "containers#index"
  get "docker/run", to: "docker#run", as: "docker_run"
  get "docker/stop", to: "docker#stop", as: "docker_stop"
  resources :containers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
