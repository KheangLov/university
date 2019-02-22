Rails.application.routes.draw do
  namespace :report do
    get 'department/index'
  end

  root 'admin/users#dashboard'
  namespace :admin do
    get '/dashboard', to: 'users#dashboard'
    resources :departments
    resources :students
    post '/students/:id', to: 'students#add_score', as: 'student_add_score'
    resources :groups
    resources :subjects
  end
  namespace :report do
    get '/reports', to: 'users#reports'
    resources :departments
    resources :students
    resources :groups
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
