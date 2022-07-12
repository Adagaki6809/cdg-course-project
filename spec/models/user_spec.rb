require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  it 'is valid' do
    is_expected.to be_valid
  end

  it 'is not valid without name' do
    subject.name = nil
    expect(subject.name).to be_nil
    is_expected.to be_invalid
  end

  it 'is not valid without email' do
    subject.email = nil
    is_expected.to be_invalid
  end

  it 'is not valid without password' do
    subject.password = nil
    is_expected.to be_invalid
  end

  it 'is not valid without identical passwords' do
    subject.password = '123456'
    subject.password_confirmation = 'abcdef'
    is_expected.to be_invalid
  end
end
