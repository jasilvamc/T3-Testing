# require 'rails_helper'

# RSpec.describe 'Products', type: :request do
#   before do
#     @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
#                          role: 'admin')
#     sign_in @user
#     @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
#   end
#   describe 'GET /new' do
#     it 'returns http success' do
#       get '/products/index'
#       expect(response).to have_http_status(:success)
#     end
#     it 'return http success without login' do
#       sign_out @user
#       get '/products/index'
#       expect(response).to have_http_status(:success)
#     end
#   end
# end

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com', role: 'admin')
    sign_in @user
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
  end

  describe 'GET /products/index' do
    it 'returns http success' do
      get '/products/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /products/leer/:id' do
    it 'returns http success' do
      get "/products/leer/#{@product.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /products/crear' do
    it 'returns http success' do
      get '/products/crear'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /products/actualizar/:id' do
    it 'returns http success' do
      get "/products/actualizar/#{@product.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /products/insertar' do
    it 'creates a new product' do
      product_params = { nombre: 'New Product', precio: 100, stock: 5, categories: 'Cancha' }

      expect do
        post '/products/insertar', params: { product: product_params }
      end.to change(Product, :count).by(1)

      expect(flash[:notice]).to eq('Producto creado Correctamente !')
      expect(response).to redirect_to('/products/index')
    end

    it 'does not create a new product if the user is not admin' do
      sign_out @user
      sign_in User.create!(name: 'John2', password: 'Nonono123!', email: 'asdf1@gmail.com', role: 'user')
      product_params = { nombre: 'New Product', precio: 100, stock: 5, categories: 'Cancha' }

      expect do
        post '/products/insertar', params: { product: product_params }
      end.to change(Product, :count).by(0)

      expect(flash[:alert]).to eq('Debes ser un administrador para crear un producto.')
      expect(response).to redirect_to('/products/index')
    end
  end

  describe 'POST /products/insert_deseado/:product_id' do
    it 'inserts a product into the user\'s wishlist' do
      user = User.create!(name: 'John2', password: 'Nonono123!', email: 'asdf2@gmail.com', role: 'user')
      sign_out @user
      sign_in user

      post "/products/insert_deseado/#{@product.id}"

      user.reload
      expect(user.deseados).to include(@product.id.to_s)
      expect(flash[:notice]).to eq('Producto agregado a la lista de deseados')
      expect(response).to redirect_to("/products/leer/#{@product.id}")
    end
  end

  # describe 'DELETE /products/eliminar/:id' do
  #   it 'deletes a product from the database' do
  #     product = Product.create!(nombre: 'Product to be deleted', precio: 100, stock: 5, categories: 'Cancha', user: @user)
      
  #     expect do
  #       delete "/products/eliminar/#{product.id}"
  #     end.to change(Product, :count).by(-1)
  
  #     expect(flash[:notice]).to eq('Producto eliminado correctamente')
  #     expect(response).to redirect_to('/products/index')
  #   end
  
  #   it 'does not delete a product if the user is not an admin' do
  #     sign_out @user
  #     sign_in User.create!(name: 'John2', password: 'Nonono123!', email: 'asdf1@gmail.com', role: 'user')
  
  #     product = Product.create!(nombre: 'Product to be deleted', precio: 100, stock: 5, categories: 'Cancha', user: @user)
      
  #     expect do
  #       delete "/products/eliminar/#{product.id}"
  #     end.to change(Product, :count).by(0)
  
  #     expect(flash[:alert]).to eq('Debes ser un administrador para eliminar un producto.')
  #     expect(response).to redirect_to('/products/index')
  #   end
  # end
  

end


