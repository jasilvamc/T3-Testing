require 'rails_helper'

RSpec.describe 'Homepage navigation', type: :system do

    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'aassdf@gmail.com',
                                role: 'admin')
        login_as(@user, scope: :user)
        end

    describe 'visiting the user info form and going back to main page' do
        it 'goes back to main page' do
        visit '/users/show'
        click_link 'Inicio'
        expect(current_path).to eq('/')
        end
    end

    describe 'visiting the user info and then the edit' do
        it 'goes back to main page' do
        visit '/users/show'
        click_link 'Editar Cuenta'
        expect(current_path).to eq('/edit')
        end
    end

    describe 'visiting the contact form and going back to main page' do
        it 'goes back to main page' do
        visit '/contacto'
        click_link 'Inicio'
        expect(current_path).to eq('/')
        end
    end

    describe 'Going to edit page, and then returning to main page' do
        it 'goes back to main page' do
        visit '/edit'
        click_link 'Inicio'
        expect(current_path).to eq('/')
    end
  end
end