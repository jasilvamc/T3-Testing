require 'rails_helper'

RSpec.describe 'Registration', type: :system do
    
# Para testear el form de registro de usuario, se testea un happy path y dos caminos alternativos, que fallan por los siguientes motivos:
# - Se ingresa un correo que ya está registrado
# - No se ingresa un correo
# Para estos tests, se revisa que el mensaje de error (o confirmación) sea el correcto, y/o que la página se redirija correctamente.
    describe 'User registration' do
        it 'registers successfully' do
          visit '/register'
      
          fill_in 'user[name]', with: 'John'
          fill_in 'user[email]', with: 'john@example.com'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
      
          click_button 'Registrarse'
      
          expect(current_path).to eq('/')
          expect(page).to have_content("¡Bienvenid@! Te has registrado exitosamente.")
        end
    end

    describe 'Dont allow same mail registration' do
        it 'registers unsuccessfully' do
        
        @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'aasssssdf@gmail.com',
        role: 'admin')
        login_as(@user, scope: :user)

        logout(:user)

        expect(current_path).to eq(nil)

        visit '/register'

        fill_in 'user[name]', with: 'John'
        fill_in 'user[email]', with: 'aasssssdf@gmail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
    
        click_button 'Registrarse'

        expect(page).to have_content("Un error impidió que fuera guardado:")
        end
    end

    describe 'Dont allow nil mail registration' do
        it 'registers unsuccessfully' do
        
        visit '/register'

        fill_in 'user[name]', with: 'John'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
    
        click_button 'Registrarse'

        expect(current_path).to eq('/register')
        end
    end
end