require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) { User.create!(email: 'user@prueba.com', password: 'p123456') }
  subject(:contact) {
    described_class.new(
      name: 'Maria Crespo', birthday: '1977-02-26', phone: '(+57) 316-480-29-36', address: 'Palmares Casa 26',
      credit_card: '30130188259195', last_digits: '9195', franchise: 'Visa', email: 'user@prueba.com', user_id: user.id
    )
  }

  describe 'Relationships' do
    it { should belong_to(:user) }
  end

  describe 'attributes validate' do
    it { is_expected.to be_valid }
    it { validate_presence_of(:name) }
    it { validate_presence_of(:birthday) }
    it { validate_presence_of(:phone) }
    it { validate_presence_of(:address) }
    it { validate_presence_of(:credit_card) }
    it { validate_presence_of(:franchise) }
    it { validate_presence_of(:email) }
  end

  describe 'name validate' do
    it {
      allow_value('Maria Niño').for(:name)
      .with_message('Name with special character arent allowed, only "-" is allowed')
    }

    it { allow_value('MariaNino').for(:name) }
    it { allow_value('Maria Nino').for(:name) }
    it { allow_value('Maria-Nino').for(:name) }
  end

  describe 'birthday format ISO 8601 validate' do
    it { allow_value('1977-02-26').for(:birthday) }
    it { allow_value('19770226').for(:birthday) }
  end

  describe 'format email validate' do
    it { allow_value('user@prueba.com').for(:email) }
    it { should_not allow_value('user@prueba').for(:email) }
    it {
      validate_uniqueness_of(:email)
      .with_message("You have a contact with the same email")
    }
  end

  describe 'format phone validate' do
    it { allow_value('(+57) 316 480 29 36').for(:phone) }
    it { allow_value('(+57) 316-480-26-36').for(:phone) }
    it {
      should_not allow_value('3164802936').for(:phone)
      .with_message('Please include de phone in the next formats: (+57) 320 432 05 09 or (+57) 320-432-05-09')
    }
  end

  describe 'last digits credit card' do
    it 'should accept Visa and get 4four last digits' do
      expect(contact.last_digits).to eq('9195')
    end
  end

  describe 'franchise validate' do
    it 'accept Visa Card' do
      contact.credit_card = '30130188259195'
      expect(contact.franchise).to eq('Visa')
    end

    it 'should reject wrong number Card' do
      contact.credit_card = '10101010'
      expect(contact.valid?).to be_falsy
    end
  end
end