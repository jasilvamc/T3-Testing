require 'rails_helper'

RSpec.describe Solicitud, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                         role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @solicitud = Solicitud.new(user: @user, product: @product, stock: 1, status: 'pending')
  end

  it 'is valid with valid attributes' do
    expect(@solicitud).to be_valid
  end

  it 'is not valid without a user' do
    @solicitud.user = nil
    expect(@solicitud).to_not be_valid
  end

  it 'is not valid without a product' do
    @solicitud.product = nil
    expect(@solicitud).to_not be_valid
  end

  it 'is not valid without stock' do
    @solicitud.stock = nil
    expect(@solicitud).to_not be_valid
  end

  it 'is not valid with a stock of 0' do
    @solicitud.stock = 0
    expect(@solicitud).to_not be_valid
  end

  it 'is not valid with a negative stock' do
    @solicitud.stock = -1
    expect(@solicitud).to_not be_valid
  end

  it 'is not valid without a status' do
    @solicitud.status = nil
    expect(@solicitud).to_not be_valid
  end
end