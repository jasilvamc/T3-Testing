# spec/controllers/solicitud_controller_spec.rb
require 'rails_helper'

RSpec.describe SolicitudController, type: :controller do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'test@example.com', role: 'user')
    @product = Product.create!(nombre: 'Sample Product', precio: 100, stock: 10, user_id: @user.id, categories: 'Cancha')
  end

  describe 'GET #index' do
    context 'when user is signed in' do
      it 'renders the index template' do
        sign_in @user
        get :index
        expect(response).to render_template('index')
      end
    end

  end

  describe 'POST #insertar' do
    context 'when user is signed in' do
      before do
        sign_in @user
      end

      context 'with valid parameters' do
        it 'creates a new solicitud and redirects to the product page' do
          expect do
            post :insertar, params: {
              product_id: @product.id,
              solicitud: { stock: 3 }
            }
          end.to change(Solicitud, :count).by(1)

          @product.reload
          expect(@product.stock).to eq("7")
          expect(response).to redirect_to("/products/leer/#{@product.id}")
          expect(flash[:notice]).to eq('Solicitud de compra creada correctamente!')
        end
      end

      context 'with invalid parameters' do
        it 'does not create a solicitud and redirects to the product page with an error message' do
          expect do
            post :insertar, params: {
              product_id: @product.id,
              solicitud: { stock: 15 }
            }
          end.not_to change(Solicitud, :count)

          @product.reload
          expect(@product.stock).to eq("10")
          expect(response).to redirect_to("/products/leer/#{@product.id}")
          expect(flash[:error]).to include('No hay suficiente stock')
        end
      end
    end

    
  end

end
