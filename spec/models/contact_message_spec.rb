require 'rails_helper'

RSpec.describe ContactMessage, type: :model do
  describe "validations" do
    it "is valid with all fields filled correctly" do
      contact_message = ContactMessage.new(
        title: "Test title",
        body: "Test body",
        name: "Test name",
        mail: "test@example.com",
        phone: "+56912345678"
      )
      expect(contact_message).to be_valid
    end
  end
end

RSpec.describe ContactMessage, type: :model do
  describe "validations" do
    it "is not valid without a title" do
      contact_message = ContactMessage.new(
        body: "Test body",
        name: "Test name",
        mail: "test@example.com",
        phone: "+56912345678"
      )
      expect(contact_message).not_to be_valid
    end
  end
end

RSpec.describe ContactMessage, type: :model do
  describe "validations" do
    it "is not valid if body is too long" do
      contact_message = ContactMessage.new(
        title: "Test title",
        body: "a" * 501,
        name: "Test name",
        mail: "test@example.com",
        phone: "+56912345678"
      )
      expect(contact_message).not_to be_valid
    end
  end
end

RSpec.describe ContactMessage, type: :model do
  describe "validations" do
    it "is not valid if mail has an invalid format" do
      contact_message = ContactMessage.new(
        title: "Test title",
        body: "Test body",
        name: "Test name",
        mail: "invalid_email",
        phone: "+56912345678"
      )
      expect(contact_message).not_to be_valid
    end
  end
end

RSpec.describe ContactMessage, type: :model do
  describe "validations" do
    it "is not valid if phone has an invalid format" do
      contact_message = ContactMessage.new(
        title: "Test title",
        body: "Test body",
        name: "Test name",
        mail: "test@example.com",
        phone: "123456789"
      )
      expect(contact_message).not_to be_valid
    end
  end
end