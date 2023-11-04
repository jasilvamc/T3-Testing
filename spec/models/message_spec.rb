require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "validations" do
    let(:user) { User.create!(name: 'John1', password: 'Nonono123!', email: 'jjvergara@gmail.com', role: 'admin') }
    let(:product) { Product.create(categories: 'Cancha', nombre: 'Test product', stock: 10, precio: 100.0, user: user) }
    let(:message) { Message.new(body: "Test body", user_id: user.id, product_id: product.id) }

    it "is valid with all fields filled correctly" do
      expect(message).to be_valid
    end

    it "is not valid without a body" do
      message.body = nil
      expect(message).not_to be_valid
    end

    it "is not valid without a user_id" do
      message.user_id = nil
      expect(message).not_to be_valid
    end

    it "is not valid without a product_id" do
      message.product_id = nil
      expect(message).not_to be_valid
    end
  end
end
