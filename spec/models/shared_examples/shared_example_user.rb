shared_examples_for "a valid user" do
  it { should be_valid }
end

shared_examples_for "an invalid user" do

  before do
    create(:sanja)
    subject.validate  #for creating errors
  end

  it { expect(subject).to be_invalid }
  it 'should show errors' do
    expect(subject.errors).to be_present
  end
end