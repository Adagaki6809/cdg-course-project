require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post, user: nil) }

  it 'is not valid' do
    is_expected.to be_invalid
  end
end
