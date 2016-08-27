Rails.application.routes.draw do
  root to: redirect('pos')

  get 'login' => 'session#login'
  post 'login' => 'session#auth'
  get 'logout' => 'session#logout'

  get 'pos' => 'pos#index'
  post 'pos' => 'pos#save'
  # edit
  get 'pos/edit/:id' => 'pos#edit', as: :edit
  post 'pos/edit/:id' => 'pos#save'
  # JSON
  get 'pos/products' => 'pos#products', as: :products_json
  get 'pos/combos' => 'pos#combos', as: :combos_json
  get 'pos/load_cart/:id' => 'pos#load_cart', as: :load_cart
  # view details & print reciept
  get 'pos/view/:id' => 'pos#view', as: :view
  # pay
  post 'pos/pay' => 'pos#pay', as: :pay
  # ship
  post 'pos/ship/:id' => 'pos#ship', as: :ship

  get 'admin' => 'admin#index'

  scope 'admin' do
    get 'dashboard' => 'admin#dashboard'
    resources :users, :products, :combos, :stocks
  end
end
