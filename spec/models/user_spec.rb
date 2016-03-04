require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(email: email, password: password, phone: phone, name: name, user_type: user_type) }

  let(:email) { "vanja@rbttt.com" }
  let(:password) { "12345rfvg" }
  let(:phone) { "0643335504" }
  let(:name) { "Vanja" }
  let(:user_type) { "1" }

  it { expect(user).to be_valid }

  describe "#email" do   #atribute that is tested

    context "when too long" do   #state is true
      let(:email) { "really really really really really really really really long email that is crazy email but is is just for test" }

      it_behaves_like "an invalid user"
    end

    context "when too short" do
      let(:email) {  "s@s.s" }

      it_behaves_like "an invalid user"
    end

    context "when is not present" do
      let(:email) { "" }

      it_behaves_like "an invalid user"
    end

    context "when is not ok format" do
      let(:email) { "vanjaaaaa" }

      it_behaves_like "an invalid user"
    end

    context "when is not unique" do
      let(:email) { "vaca@rbt.com" }

      it_behaves_like "an invalid user"
    end

  end

  describe "#password" do

    context "when too short" do
      let(:password) { "bla" }

      it_behaves_like "an invalid user"
    end

    context "when is not present" do
      let(:password) { "" }

      it_behaves_like "an invalid user"
    end
  end

  describe "#phone" do

    context 'when is invalid format' do
      let(:phone) { "44bhbhhb" }

      it_behaves_like "an invalid user"
    end

    context "when is nil" do
      let(:phone) {nil}

      it_behaves_like "a valid user"
    end

    context "when is empty string" do
      let(:phone) {""}

      it_behaves_like "a valid user"
    end
  end

  describe "#name" do

    context "when is nil" do
      let(:name) { nil }

      it_behaves_like "a valid user"
    end

    context "when is empty string" do
      let(:name) { "" }

      it_behaves_like "a valid user"
    end
  end

  describe "#user_type" do

    context "when is boolean value" do
      let(:user_type) { true }

      it_behaves_like "a valid user"
    end

    context "when is 1 or 0 value" do
      let(:user_type) { 1 }

      it_behaves_like "a valid user"
    end

    context "when is empty" do
      let(:user_type) { "" }

      it_behaves_like "an invalid user"
    end

    context "when is nil" do
      let(:user_type) { nil }

      it_behaves_like "an invalid user"
    end
  end

  describe "#user_data" do

    context "when all exist" do
      let(:email) { "vanja@rbt.com" }
      let(:name) { "Vanja" }
      let(:phone) { "0643400444" }
      #let(:user_data) { [name,email,phone].compact.join(' ')}

      it { expect(user.user_data).to eql("Vanja vanja@rbt.com 0643400444") }
    end
  end

end