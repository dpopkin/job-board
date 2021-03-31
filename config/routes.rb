Rails.application.routes.draw do
  root to: proc { [404, {}, ['']]}
  resources :job_boards, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
