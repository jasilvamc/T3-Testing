require 'rails_helper'

RSpec.describe 'Create product navigation', type: :system do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'aassdf@gmail.com',
                         role: 'admin')
    login_as(@user, scope: :user)
  end

  describe 'visiting the product form and going back to main page' do
    it 'goes back to main page' do
      visit '/products/crear'
      click_link 'Cancelar'
      expect(current_path).to eq(nil)
    end
  end

  describe 'visiting the product form' do
    it 'have form' do
      visit '/products/crear'
      expect(page).to have_selector('h1', text: 'Crear Producto')
    end

    it 'not allowed on the product form' do
      logout(:user)
      visit '/products/crear'
      expect(page).to have_selector('div', text: 'No estás autorizado para acceder a esta página')
    end
  end
end

  