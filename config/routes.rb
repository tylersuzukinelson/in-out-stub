ClioInOutStub::Application.routes.draw do

  devise_for :users

  resources :users, :only => [:index, :show, :edit, :update] do
    member do
      get :status
    end
    collection do
      get :status_all
    end
  end

  resources :teams, only: [:index]

  root :to => "users#index"

end
