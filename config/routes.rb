Rails.application.routes.draw do
  root to: redirect('pos')

  get 'login' => 'session#login'
  post 'login' => 'session#auth'
  get 'logout' => 'session#logout'

  get 'orders' => 'orders#index'

  get 'pos' => 'pos#index'
  post 'pos' => 'pos#save', as: :save
  # edit
  get 'pos/edit/:id' => 'pos#edit', as: :edit_order
  # JSON
  get 'pos/products' => 'pos#products'
  get 'pos/combos' => 'pos#combos'
  # view details & print reciept
  get 'orders/:id' => 'orders#view', as: :view_order
  post 'orders/:id/pay' => 'orders#pay', as: :pay_order
  post 'orders/:id/ship' => 'orders#ship', as: :ship_order

  get 'admin' => 'admin#index'

  scope 'admin' do
    get 'dashboard' => 'admin#dashboard'
    resources :users, :products, :combos, :stocks
  end

  # TODO: group together with resources:products
  get 'products/images/:id' => 'products#img', as: :product_img
  # TODO: combo_img
end
