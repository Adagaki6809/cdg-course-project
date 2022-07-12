require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { create(:post) }

  it 'is valid' do
    is_expected.to be_valid
  end

  it 'is not valid without image' do
    subject.image = nil
    is_expected.to be_invalid
  end
end
