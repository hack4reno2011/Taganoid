Taganoid::Application.routes.draw do
  
  ##################################################################
  ## Public pages ##
  ##################################################################
  match 'tag/new' => 'tag#new', :via => :post
  match 'tag/thanks' => 'tag#thanks'
     
  ##################################################################
  root :to => 'home#index'

  ##################################################################
  ## Entries ##
  ##################################################################
  resources :entries        

  ##################################################################
  ## Reports ##
  ##################################################################
  resource :report, :controller => :reports, :only => [] do
    member do
      get :check_for_delayed_tasks
    end
  end
  

  ##################################################################
  ## Settings ##
  ##################################################################
  namespace :setting do
    resources :entry_types, :except => [:show]
    resources :statuses, :except => [:show]
    resources :groups, :except => [:show]
  end

   
  ##################################################################
  ## CRON PROCESSES ##
  ##################################################################
  resource :process, :controller => :app_processes, :only => [] do
    member do
      get :check_for_delayed_tasks
    end
  end
end

