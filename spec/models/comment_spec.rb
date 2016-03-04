require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { FactoryGirl.build(:comment, body:body) }
  let(:body){'This is my body'}

  it {expect(subject).to be_valid}

  shared_examples_for 'invalid comment' do
    it{ expect(subject).to be_invalid }
  end

  describe "#body" do
    context "too long" do
      let(:body) { "This is too long body for one regular comment and I can't allow it"}

      it_behaves_like 'invalid comment'
    end

    context "too short" do
      let(:body) { "Too"}

      it_behaves_like 'invalid comment'
    end

    context "when is nil" do
      let(:body) { nil }

      it_behaves_like 'invalid comment'
    end

    context "when is empty" do
      let(:body) { 'nil' }

      it_behaves_like 'invalid comment'
    end
  end

end
