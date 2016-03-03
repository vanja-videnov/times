require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(email: email, password: password) }

  let(:email) { "vanja@rbttt.com" }
  let(:password) { "12345rfvg" }
  let(:vanja) { User.new(email: "vaca@rbt.com", password: "123454f") }

  it { expect(user).to be_valid }

  describe "#email" do   #atribute that is tested

    shared_examples_for "an invalid user" do
      before do
        subject.validate  #for creating errors
      end

      # it { should be_invalid }
      it { expect(subject).to be_invalid }
      it 'should show errors' do
        expect(subject.errors).to be_present
      end
    end

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

  end

  describe "#password" do

    context "when too short" do
      let(:password) { "bla" }

      it { expect(user).to be_invalid }
    end

    context "when is not present" do
      let(:password) { "" }

      it { expect(user).to be_invalid }
    end
  end

  describe "#user_data" do

    context "when all exist" do
      let(:email) { "vanja@rbt.com" }
      let(:password) { "123456d" }
      #let(:user_data) { [email,password].compact.join(' ')}

      it { expect(user.user_data).to eql("vanja@rbt.com 123456d") }
    end
  end

end




# describe '#create' do
#   context 'when something is like this' do
#     subject { described_class.new.value }
#
#     it 'should return expected value' do
#       expect(described_class.new.value).to eq('my expectation')
#     end
#
#     it { should eq('my expectation') }
#   end
#
#   context 'when something is like that' do
#
#   end
# end
