require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let(:user) { create :user }
  let(:user2) { create :user }
  before { sign_in user }

  describe '#create' do
    subject { process :create, params: {followed_id: user2 } }
    it 'follows @user2' do
      subject
      expect(user.following?(user2)).to eq true
    end
  end
end
