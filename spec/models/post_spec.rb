require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: title, body: body) }
  let(:title) { 'My new title' }
  let(:body) { 'This is my body' }

  it { should be_valid }

  shared_examples_for 'invalid post' do
    it { should be_invalid }
  end

  describe '#title' do

    context 'when is too short' do
      let(:title) { 'short' }

      it_behaves_like 'invalid post'
    end

    context 'too long' do
      let(:title) { 's'*16 }

      it_behaves_like 'invalid post'
    end

    context 'when is not present' do
      let(:title) { '' }

      it_behaves_like 'invalid post'
    end

    context 'when is nil' do
      let(:title) { nil }

      it_behaves_like 'invalid post'
    end
  end

  describe '#body' do

    context 'when is too short' do
      let(:body) { 's'*5 }

      it_behaves_like 'invalid post'
    end

    context 'when is too long' do
      let(:body) { 's'*155 }

      it_behaves_like 'invalid post'
    end

    context 'when is nil' do
      let(:body) { nil }

      it_behaves_like 'invalid post'
    end

    context 'when is empty' do
      let(:body) { '' }

      it_behaves_like 'invalid post'
    end
  end

  describe '#with_comments_method' do

    context 'when is ok' do
      before do
        @post=FactoryGirl.create(:post2)
        FactoryGirl.create(:comment)
        FactoryGirl.create(:comment2)
      end

      it{ expect(Post.with_comments(@post.id).comments.count).to eql(2) }
    end
  end
end


#     context 'too short' do
#       let(:title) { 'short' }
#
#       it 'raise exception on save' do
#         expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
#       end
#     end

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
