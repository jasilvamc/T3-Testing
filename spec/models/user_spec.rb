require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                     role: 'admin')
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'is not valid without a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid with a name shorter than 2 characters' do
    @user.name = 'a'
    expect(@user).to_not be_valid
  end

  it 'is not valid with a name longer than 25 characters' do
    @user.name = 'a' * 26
    expect(@user).to_not be_valid
  end

  it 'is not valid without an email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid with a duplicate email' do
    User.create!(name: 'John2', password: 'Nonono123!', email: 'asdf@gmail.com',
                 role: 'admin')
    expect(@user).to_not be_valid
  end

  it 'is not valid without a password' do
    @user.password = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid if password is blank' do
    @user.password = ""
    expect(@user).to_not be_valid
  end

  it 'is valid with a strong password' do
    @user.password = 'StrongPassword1!'
    expect(@user).to be_valid
  end

  it 'is not valid with a desired product that does not exist' do
    @user.deseados << 999
    expect(@user).to_not be_valid
    end

    it 'is valid with a password without a lowercase letter' do
    @user.password = 'PASSWORD1!'
    expect(@user).to be_valid
    end
    
    it 'is valid with a password without an uppercase letter' do
    @user.password = 'password1!'
    expect(@user).to be_valid
    end
    
    it 'is valid with a password without a digit' do
    @user.password = 'Password!'
    expect(@user).to be_valid
    end
    
    it 'is valid with a password without a non-alphanumeric character' do
    @user.password = 'Password1'
    expect(@user).to be_valid
    end
end