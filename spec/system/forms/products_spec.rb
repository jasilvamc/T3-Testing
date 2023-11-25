require 'rails_helper'

# Para testear el form de creación de producto, se testea un happy path y tres caminos alternativos, que fallan por los siguientes motivos:
# - No se ingresa el nombre del producto
# - El precio del producto no es un número
# - El stock del producto no es un número
# Para todos estos tests, primero se crea un usuario admin que pueda crear los productos. 
# Luego se intenta crear (con diferentes resultados dependiendo de si es happy path o no) y se 
# revisa que el mensaje de error (o confirmación) sea el correcto.
RSpec.describe 'Products', type: :system do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                         role: 'admin')
    login_as(@user, scope: :user)
  end

  # Test para la correcta creación de un producto con happy path y 3 paths alternativos
  describe 'Creating a product' do
    before do
      @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdfggg@gmail.com', role: 'admin')
      login_as(@user, scope: :user)
    end
  
    it 'creates a new product' do
      visit '/products/crear'
  
      fill_in 'Nombre', with: 'New Product'
      fill_in 'Precio', with: '100'
      fill_in 'Stock', with: '50'
      fill_in 'Horarios', with: 'Monday,9,5;Tuesday,9,5'
  
      click_button 'Guardar'
      
      expect(current_path).to eq('/products/index')
      expect(page).to have_content('Producto creado Correctamente !')
    end

    it 'fails to create a product when Stock is NAN' do
      visit '/products/crear'
  
      fill_in 'Nombre', with: 'New Product'
      fill_in 'Precio', with: '100'
      fill_in 'Stock', with: 'No un numero'
      fill_in 'Horarios', with: 'Monday,9,5;Tuesday,9,5'
  
      click_button 'Guardar'
      
      expect(current_path).to eq('/products/crear')
      expect(page).to have_content('Hubo un error al guardar el producto: Stock: no es un número')
    end

    it 'fails to create a product when Price is NAN' do
      visit '/products/crear'
  
      fill_in 'Nombre', with: 'New Product'
      fill_in 'Precio', with: 'No un numero'
      fill_in 'Stock', with: '10'
      fill_in 'Horarios', with: 'Monday,9,5;Tuesday,9,5'
  
      click_button 'Guardar'
      
      expect(current_path).to eq('/products/crear')
      expect(page).to have_content('Hubo un error al guardar el producto: Precio: no es un número')
    end

    it 'fails to create a product when there is no name' do
      visit '/products/crear'
  
      fill_in 'Nombre', with: ''
      fill_in 'Precio', with: 'No un numero'
      fill_in 'Stock', with: '10'
      fill_in 'Horarios', with: 'Monday,9,5;Tuesday,9,5'
  
      click_button 'Guardar'
      
      expect(current_path).to eq('/products/crear')
    end

  end
end
