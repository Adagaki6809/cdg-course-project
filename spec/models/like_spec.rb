require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { create(:like) }

  it 'is valid' do
    is_expected.to be_valid
  end
end
