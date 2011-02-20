Springfieldrb::Application.routes.draw do
  root :to => 'members#index'

  resources :members
end
