require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { create(:comment) }

  it 'is valid' do
    is_expected.to be_valid
  end

  it 'is not valid without a content' do
    subject.content = nil
    is_expected.to be_invalid
  end
end
