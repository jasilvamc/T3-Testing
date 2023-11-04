require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                         role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @shopping_cart = ShoppingCart.new(user: @user, products: { @product.id => 1 })
  end

  it 'is valid with valid attributes' do
    expect(@shopping_cart).to be_valid
  end

  it 'is not valid without a user' do
    @shopping_cart.user = nil
    expect(@shopping_cart).to_not be_valid
  end

  it 'calculates the total price correctly' do
    expect(@shopping_cart.precio_total).to eq(4000)
  end

  it 'calculates the shipping cost correctly' do
    expect(@shopping_cart.costo_envio).to eq(1200)
  end
end