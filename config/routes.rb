Rails.application.routes.draw do
  root 'top#show'

  get 'authentication/new'
  get 'authentication' => 'authentication#create'

  post 'top' => 'top#execute'
end
