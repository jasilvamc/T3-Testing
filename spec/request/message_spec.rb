# spec/controllers/message_controller_spec.rb
require 'rails_helper'

RSpec.describe MessageController, type: :controller do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com', role: 'user')
    @product = Product.create!(nombre: 'Sample Product', precio: 100, stock: 10, user_id: @user.id, categories: 'Cancha')
    @message = Message.create(body: 'Sample message', user_id: @user.id, product_id: @product.id)
  end


  describe 'POST #insertar' do
    context 'with valid parameters' do
      it 'creates a new message' do
        message_params = {
          body: 'New message'
        }

        sign_in @user

        expect do
          post :insertar, params: { product_id: @product.id, message: message_params }
        end.to change(Message, :count).by(1)

        expect(flash[:notice]).to eq('Pregunta creada correctamente!')
        expect(response).to redirect_to("/products/leer/#{@product.id}")
      end
    end

    context 'with invalid parameters' do
      it 'does not create a message' do
        message_params = {
          body: '', # Invalid: body is required
        }

        sign_in @user

        expect do
          post :insertar, params: { product_id: @product.id, message: message_params }
        end.to change(Message, :count).by(0)

        expect(flash[:error]).to include("Hubo un error al guardar la pregunta")
        expect(response).to redirect_to("/products/leer/#{@product.id}")
      end
    end
  end
end
