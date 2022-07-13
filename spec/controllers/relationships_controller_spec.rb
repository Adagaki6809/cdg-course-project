require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let(:user) { create :user }
  let(:user2) { create :user }
  before { sign_in user }

  describe '#create' do
    subject { process :create, params: { followed_id: user2 } }
    it 'follows @user2' do
      subject
      expect(user.following?(user2)).to eq true
    end
  end

  describe '#destroy' do
    let!(:relationship) { user.follow(user2) }
    subject { process :destroy, params: { id: relationship.id } }
    it 'unfollows from @user2' do
      expect(user.following?(user2)).to eq true
      subject
      expect(user.following?(user2)).to eq false
    end
  end
end
