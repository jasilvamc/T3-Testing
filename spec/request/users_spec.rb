# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com', role: 'admin')
    sign_in @user
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show
      expect(response).to render_template('show')
    end
  end

  describe 'GET #deseados' do
    it 'renders the deseados template' do
      get :deseados
      expect(response).to render_template('deseados')
    end
  end

  describe 'GET #mensajes' do
    it 'renders the mensajes template' do
      get :mensajes
      expect(response).to render_template('mensajes')
    end
  end
end
