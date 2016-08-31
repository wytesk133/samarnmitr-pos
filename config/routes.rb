Rails.application.routes.draw do
  root to: redirect('pos')

  get 'login' => 'session#login'
  post 'login' => 'session#auth'
  get 'logout' => 'session#logout'

  get 'orders' => 'orders#index'

  get 'pos' => 'pos#index'
  post 'pos' => 'pos#save', as: :save
  # edit
  get 'pos/edit/:id' => 'pos#edit', as: :edit
  # JSON
  get 'pos/products' => 'pos#products'
  get 'pos/combos' => 'pos#combos'
  # view details & print reciept
  get 'orders/:id' => 'pos#view', as: :view
  # pay
  post 'orders/:id/pay' => 'pos#pay', as: :pay
  # ship
  post 'orders/:id/ship' => 'pos#ship', as: :ship

  get 'admin' => 'admin#index'

  scope 'admin' do
    get 'dashboard' => 'admin#dashboard'
    resources :users, :products, :combos, :stocks
  end

  # TODO: group together with resources:products
  get 'products/images/:id' => 'products#img', as: :product_img
  # TODO: combo_img
end
