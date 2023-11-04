# spec/controllers/review_controller_spec.rb
require 'rails_helper'

RSpec.describe ReviewController, type: :controller do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com', role: 'user')
    @product = Product.create!(nombre: 'Sample Product', precio: 100, stock: 10, user_id: @user.id, categories: 'Cancha')
  end

  describe 'POST #insertar' do
    context 'with valid parameters' do
      it 'creates a new review' do
        review_params = {
          tittle: 'Great product',
          description: 'I love this product!',
          calification: 5
        }

        sign_in @user

        expect do
          post :insertar, params: { product_id: @product.id, review: review_params }
        end.to change(Review, :count).by(1)

        expect(flash[:notice]).to eq('Review creado Correctamente !')
        expect(response).to redirect_to("/products/leer/#{@product.id}")
      end
    end

    context 'with invalid parameters' do
      it 'does not create a review' do
        review_params = {
          tittle: '', # Invalid: tittle is required
          description: 'This is a test description',
          calification: 6 # Invalid: calification is out of the range
        }

        sign_in @user

        expect do
          post :insertar, params: { product_id: @product.id, review: review_params }
        end.to change(Review, :count).by(0)

        expect(flash[:error]).to include("Hubo un error al guardar la reseña")
        expect(response).to redirect_to("/products/leer/#{@product.id}")
      end
    end
  end
end
