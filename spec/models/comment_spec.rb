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

  describe '#for_user_method' do
    context 'when is ok' do
      before do
        FactoryGirl.create(:comment)
        FactoryGirl.create(:comment2)
        @user=FactoryGirl.create(:not_admin)
      end

      it {expect(@user.comments.count).to eql(2)}
    end

    context 'when is eql to database' do
      before do
        FactoryGirl.create(:comment)
        FactoryGirl.create(:comment2)
        @user=FactoryGirl.create(:sanja)
      end

      it {expect(Comment.for_user(@user.id).count).to eql(@user.comments.count)}
    end
  end

  describe 'for_post' do
    context 'when is ok' do
      before do
        @post=FactoryGirl.create(:post2)
        FactoryGirl.create(:comment)
        FactoryGirl.create(:comment2)
      end

      it {expect(Comment.for_post(@post.id).count).to eql(2)}
    end

    context 'when is eql to database' do
      before do
        @post=FactoryGirl.create(:post2)
        FactoryGirl.create(:comment)
        FactoryGirl.create(:comment2)
      end

      it {expect(Comment.for_post(@post.id).count).to eql(@post.comments.count)}
    end
  end

  describe '#owner' do
    before do
      @com2 = FactoryGirl.create(:comment2)
      @com = FactoryGirl.create(:comment2, user_id: 2)
      @not_admin = FactoryGirl.create(:not_admin)
      @admin = FactoryGirl.create(:sanja)
    end
    context 'when is owner' do
      it 'returns comment owner' do
        expect(User.find_by(id: @com2.user_id)).to eq(@com2.owner)
      end
    end
    context 'when is not owner' do
      it 'dont return comment owner' do
        expect(User.find_by(id: @com2.user_id)).not_to eq(@com.owner)
      end
    end
  end

end
