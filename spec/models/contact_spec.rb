require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) {
    User.create(email: "maria@prueba.com", password: "123456")
  }
  subject {
    described_class.new(name: "Maria Crespo",
                        birthday: "1977-02-26",
                        address: "Cra 15 12 13",
                        credit_card: "1234561236541236",
                        franchise: "Visa",
                        email: "mafe@prueba.com",
                        phone: "(+57) 316 480 29 36",
                        user_id: user.id)
  }
  describe Contact do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:franchise) }
    it { should validate_presence_of(:credit_card) }
    it { should validate_presence_of(:email) }
    #it { should validate_presence_of(:birthday) }
    
    context "when email is not unique" do
      before { described_class.create!(name: "Maria Crespo",
                                        birthday: "1977-02-26",
                                        address: "Cra 15 12 13",
                                        credit_card: "1234561236541236",
                                        franchise: "Visa",
                                        email: "mafe@prueba.com",
                                        phone: "(+57) 316 480 29 36",
                                        user_id: user.id) }
      it {expect(subject).to be_invalid}
    end

    context "when email is  unique" do
      before { described_class.create!(name: "Maria Crespo",
                                        birthday: "1977-02-26",
                                        address: "Cra 15 12 13",
                                        credit_card: "1234561236541236",
                                        franchise: "Visa",
                                        email: "mafe2@prueba.com",
                                        phone: "(+57) 316 480 29 36",
                                        user_id: user.id) }
      it {expect(subject).to be_valid}
    end
  end


end
