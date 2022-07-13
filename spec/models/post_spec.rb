require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { create(:post, user: user) }

  let(:user) { create :user }

  it 'is valid' do
    is_expected.to be_valid
  end

  it 'is not valid without image' do
    subject.image = nil
    is_expected.to be_invalid
  end

  it 'user is an author of the post' do
    expect(subject.author?(user)).to eq true
  end

  it 'another user is not an author of the post' do
    expect(subject.author?(create(:user))).to eq false
  end
end
