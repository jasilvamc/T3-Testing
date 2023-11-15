# spec/controllers/contact_message_controller_spec.rb
require 'rails_helper'

RSpec.describe ContactMessageController, type: :controller do
  describe 'POST #crear' do
    context 'with valid parameters' do
      it 'creates a new contact message' do
        contact_params = {
          name: 'John Doe',
          mail: 'johndoe@example.com',
          title: 'Test Message',
          body: 'This is a test message.'
        }

        post :crear, params: { contact: contact_params }

        expect(response).to redirect_to('/contacto')
        expect(flash[:notice]).to eq('Mensaje de contacto enviado correctamente')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a contact message' do
        contact_params = {
          name: '', # Invalid: name is required
          mail: 'invalid_email', # Invalid: mail format is invalid
          title: 'Test Message',
          body: 'This is a test message.'
        }

        post :crear, params: { contact: contact_params }

        expect(response).to redirect_to('/contacto')
        expect(flash[:alert]).to include("Error al enviar el mensaje de contacto")
      end
    end
  end

  describe 'GET #mostrar' do
    it 'displays all contact messages' do
      contact_message1 = ContactMessage.create(
        name: 'Alice',
        mail: 'alice@example.com',
        title: 'Message 1',
        body: 'This is message 1'
      )

      contact_message2 = ContactMessage.create(
        name: 'Bob',
        mail: 'bob@example.com',
        title: 'Message 2',
        body: 'This is message 2'
      )

      get :mostrar

      expect(response).to have_http_status(:success)
      expect(assigns(:contact_messages)).to match_array([contact_message1, contact_message2])
      expect(response).to render_template('contacto')
    end
  end

  describe 'DELETE #eliminar' do
    it 'deletes a contact message' do
      contact_message = ContactMessage.create(
        name: 'Alice',
        mail: 'alice@example.com',
        title: 'Message 1',
        body: 'This is message 1'
      )

      delete :eliminar, params: { id: contact_message.id }

      expect(response).to redirect_to('/contacto')
      expect(flash[:notice]).to eq('Mensaje de contacto eliminado correctamente')

      expect(ContactMessage.find_by(id: contact_message.id)).to be_nil

    end
  end

end
