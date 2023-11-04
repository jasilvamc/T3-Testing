require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  before(:each) do
  @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
  role: 'admin')
  @user2 = User.create!(name: 'John2', password: 'Nonono123!', email: 'jjvergara@g.com', role: 'user')
  @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
  @ability = Ability.new(@user)
  @ability2 = Ability.new(@user2)
  end
  context 'when user is admin' do
    it 'can manage all' do
      expect(@ability).to be_able_to(:manage, :all)
    end
  end

  context 'when user is present' do
    it 'can perform certain actions on Product, Review, Message and Solicitud' do
    expect(@ability).to be_able_to(%i[index leer insertar crear], Product)
    expect(@ability).to be_able_to(%i[index leer insertar crear], Review)
    expect(@ability).to be_able_to(%i[leer insertar], Message)
    expect(@ability).to be_able_to([:index], Solicitud)
  end

  it 'can insert a desired product if the product is not his' do
    expect(@ability).to be_able_to([:insert_deseado], Product.new(user_id: @user.id + 1))
  end

  it 'can insert a request if the request is not his' do
    expect(@ability).to be_able_to([:insertar], Solicitud.new(user_id: @user.id + 1))
  end

  it 'can delete and update a product if the product is his' do
    expect(@ability).to be_able_to([:eliminar, :actualizar_producto, :actualizar], @product)
  end

  it 'can delete and read a request if the request is his' do
    solicitud = Solicitud.create!(user_id: @user.id, product_id: @product.id, stock: 1, status: 'pending')
    expect(@ability).to be_able_to([:eliminar, :leer], solicitud)
  end

  it 'can delete and read a request if the request is his' do
    solicitud = Solicitud.create!(user_id: @user.id, product_id: @product.id, stock: 1, status: 'pending')
    expect(@ability).to be_able_to([:eliminar, :leer], solicitud)
  end    

  it 'can insert a desired product if the product is his' do
    product = Product.create!(nombre: 'John2', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    expect(@ability).to be_able_to([:insert_deseado], product)
  end

  it 'can insert a desired product if the product is not his' do
    product = Product.create!(nombre: 'John2', precio: 4000, stock: 1, user_id: @user2.id, categories: 'Cancha')
    expect(@ability).to be_able_to([:insert_deseado], product)
  end

  it 'can insert a request if the request is his' do
    expect(@ability).to be_able_to([:insertar], Solicitud.new(user_id: @user.id))
  end

  it 'cannot delete and update a product if the product is not his' do
    expect(@ability).to be_able_to([:eliminar, :actualizar_producto, :actualizar], Product.new(user_id: @user2.id + 1))
  end

  it 'cannot delete and update a request if the product of the request is not his' do
    product = Product.create!(nombre: 'John2', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    solicitud = Solicitud.create!(user_id: @user.id, product_id: product.id, stock: 1, status: 'pending')
    expect(@ability2).to_not be_able_to([:eliminar, :actualizar], solicitud)
    end
  end
end