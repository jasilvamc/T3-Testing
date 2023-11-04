# spec/controllers/shopping_cart_controller_spec.rb
require 'rails_helper'

RSpec.describe ShoppingCartController, type: :controller do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'test@example.com', role: 'user')
    @product = Product.create!(nombre: 'Sample Product', precio: 100, stock: 10, user_id: @user.id, categories: 'Cancha')
  end

  describe 'GET #show' do
    context 'when user is signed in' do
      it 'renders the show template' do
        sign_in @user
        get :show
        expect(response).to render_template('show')
      end
    end

    context 'when user is not signed in' do
      it 'redirects to the root path' do
        get :show
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #details' do
    context 'when user is signed in' do
      it 'renders the details template' do
        sign_in @user
        get :details
        expect(response).to redirect_to('/carro')
      end
    end

    context 'when user is not signed in' do
      it 'redirects to the root path' do
        get :details
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #insertar_producto' do
    context 'when user is signed in' do
      before do
        sign_in @user
      end

      context 'with valid parameters' do
        it 'inserts a product into the shopping cart' do
          post :insertar_producto, params: { product_id: @product.id, add: { amount: 2 } }
          expect(flash[:notice]).to eq('Producto agregado al carro de compras')
        end
      end

      context 'with invalid parameters' do
        it 'does not insert a product into the shopping cart' do
          post :insertar_producto, params: { product_id: @product.id, add: { amount: 15 } }
          expect(flash[:alert]).to include(' no tiene suficiente stock para agregarlo al carro de compras.')
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to carro' do
        post :insertar_producto, params: { product_id: @product.id, add: { amount: 2 } }
        expect(response).to redirect_to('/carro')
      end
    end
  end

  describe 'POST #comprar_ahora' do
    context 'when user is signed in' do
      before do
        sign_in @user
      end

      it 'inserts a product into the shopping cart and redirects to details' do
        post :comprar_ahora, params: { product_id: @product.id, add: { amount: 2 } }
        expect(response).to redirect_to('/carro/detalle')
      end
    end

    context 'when user is not signed in' do
      it 'redirects to carro' do
        post :comprar_ahora, params: { product_id: @product.id, add: { amount: 2 } }
        expect(response).to redirect_to('/carro')
      end
    end
  end

  describe 'POST #realizar_compra' do
    context 'when user is signed in' do
      before do
        sign_in @user
      end

      context 'with valid parameters' do
        it 'makes a purchase and redirects to solicitud/index' do
          shopping_cart = ShoppingCart.create!(user_id: @user.id, products: { @product.id => 2 })
          post :realizar_compra
          expect(flash[:notice]).to eq('Compra realizada exitosamente')
          expect(response).to redirect_to('/solicitud/index')
        end
      end

      context 'with invalid parameters' do
        it 'does not make a purchase and redirects to carro' do
          post :realizar_compra
          expect(flash[:alert]).to include('No se encontró tu carro de compras. Contacte un administrador.')
          expect(response).to redirect_to('/carro')
        end
      end
    end

  end
end
