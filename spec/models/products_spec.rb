# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                         role: 'admin')
    @product = Product.new(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
  end

  it 'is valid with valid attributes' do
    expect(@product).to be_valid
  end

  it 'is not valid without a name' do
    @product.nombre = nil
    expect(@product).to_not be_valid
  end

  it 'is not valid without a price' do
    @product.precio = nil
    expect(@product).to_not be_valid
  end

  it 'is not valid with a negative price' do
    @product.precio = -1
    expect(@product).to_not be_valid
  end

  it 'is not valid without stock' do
    @product.stock = nil
    expect(@product).to_not be_valid
  end

  it 'is not valid with negative stock' do
    @product.stock = -1
    expect(@product).to_not be_valid
  end

  it 'is not valid without a user' do
    @product.user_id = nil
    expect(@product).to_not be_valid
  end

  it 'is not valid without a category' do
    @product.categories = nil
    expect(@product).to_not be_valid
  end

  it 'is not valid with an invalid category' do
    @product.categories = 'Invalid'
    expect(@product).to_not be_valid
  end
end


