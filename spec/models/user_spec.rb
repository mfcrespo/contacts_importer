require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
  described_class.new(email: "maria@prueba.com", password: "123456")
  }

  describe User do
    it { should have_many(:contacts).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    
    context "when email is not unique" do
    before { described_class.create!(email: "maria@prueba.com", password: "123456") }
    it {expect(subject).to be_invalid}
    end

    context "when email is  unique" do
    before { described_class.create!(email: "maria2@prueba.com", password: "123456") }
    it {expect(subject).to be_valid}
    end

  end
end