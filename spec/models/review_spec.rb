require 'rails_helper'

RSpec.describe Review, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                         role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @review = Review.new(tittle: 'Great product!', description: 'I really love this product.', calification: 5, product: @product, user: @user)
  end

  it 'is valid with valid attributes' do
    expect(@review).to be_valid
  end

  it 'is not valid without a title' do
    @review.tittle = nil
    expect(@review).to_not be_valid
  end

  it 'is not valid with a title longer than 100 characters' do
    @review.tittle = 'a' * 101
    expect(@review).to_not be_valid
  end

  it 'is not valid without a description' do
    @review.description = nil
    expect(@review).to_not be_valid
  end

  it 'is not valid with a description longer than 500 characters' do
    @review.description = 'a' * 501
    expect(@review).to_not be_valid
  end

  it 'is not valid without a calification' do
    @review.calification = nil
    expect(@review).to_not be_valid
  end

  it 'is not valid with a calification less than 1' do
    @review.calification = 0
    expect(@review).to_not be_valid
  end

  it 'is not valid with a calification greater than 5' do
    @review.calification = 6
    expect(@review).to_not be_valid
  end

  it 'is not valid without a product' do
    @review.product = nil
    expect(@review).to_not be_valid
  end

  it 'is not valid without a user' do
    @review.user = nil
    expect(@review).to_not be_valid
  end
end