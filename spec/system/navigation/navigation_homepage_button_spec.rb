require 'rails_helper'

RSpec.describe 'Homepage navigation', type: :system do

  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'aassdf@gmail.com',
                         role: 'admin')
    login_as(@user, scope: :user)
  end
  
  describe 'visiting the register form and going back to main page' do
    it 'goes back to main page' do
      visit '/register'
      click_link 'Inicio'
      expect(current_path).to eq('/')
    end
  end

  describe 'visiting the login form and going back to main page' do
    it 'goes back to main page' do
      visit '/login'
      click_link 'Inicio'
      expect(current_path).to eq('/')
    end
  end

  describe 'visiting the contact form and going back to main page' do
    it 'goes back to main page' do
      visit '/contacto'
      click_link 'Inicio'
      expect(current_path).to eq('/')
    end
  end

  describe 'Going to main page from the main page' do
    it 'goes back to main page' do
      visit '/'

      sleep 1

      click_link 'Inicio'
      expect(current_path).to eq('/')
    end
  end
end