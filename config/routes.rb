Rails.application.routes.draw do
  mount Qa::Engine => '/authorities'
  mount QaServer::Engine, at: '/'
  resources :welcome, only: 'index'
  root 'qa_server/homepage#index'

  namespace :bpldc do
    get 'authorities', to: 'authorities#index'
    get 'authorities/subjects', to: 'authorities#subjects'
    get 'authorities/genres', to: 'authorities#genres'
    get 'authorities/names', to: 'authorities#names'
    get 'authorities/geographics', to: 'authorities#geographics'
    get 'resource_types', to: 'nomenclatures#resource_types'
    get 'roles', to: 'nomenclatures#roles'
    get 'languages', to: 'nomenclatures#languages'
    get 'licenses', to: 'licenses#index'
  end
end
