require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { described_class.new(title: title) }
  let(:title) { 'My new title' }

  # let(:post) { FactoryGirl.create(:post, title: title) }
  # it { expect(post).to be_valid }

  it { should be_valid }

  describe "#title" do

    context "too short" do
      let(:title) { 'short' }

      it { should be_invalid }

      # before do
      #   post.title = ""
      #   possst= FactoryGirl.create(:short_title_post)
      # end
      #
      # it { expect(possst).to be_invalid }
    end

    context "too long" do

    end

    context 'DB' do
      subject { FactoryGirl.build(:post, title: title) }

      it { should be_valid}

      context 'too short' do
        let(:title) { 'short' }

        it { should be_invalid }      end
    end

    context 'DB persist' do
      subject { FactoryGirl.create(:post, title: title) }

      it { should be_truthy}

      it do
        expect(subject).to be_truthy
      end

      context 'too short' do
        let(:title) { 'short' }

        it 'raise exception on save' do
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
