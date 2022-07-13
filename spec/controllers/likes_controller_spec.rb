require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create :user }
  let(:post) { create :post, user: user }
  before do
    sign_in user 
    request.env['HTTP_REFERER'] = 'posts/'
  end

  describe '#index' do
    subject { process :index, params: params }
    let(:params) { { user_id: user, post_id: post } }
    let(:likes) { create_list(:like, 5) }

    it 'assigns @likes' do
      subject
      expect(assigns(:likes)).to eq likes
    end

    context 'when user is not signed in' do
      before { sign_out user }
      it 'redirects to the sign in page' do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#create' do
    subject { process :create, method: :post, params: params }
    let(:like) { create(:like, user: user, post: post) }
    let(:params) { { like: attributes_for(:like), user_id: user, post_id: post } }

    it 'creates a like' do
      expect(assigns(:likes_from_user).nil?).to eq true
      expect(user.likes.count).to eq 0
      expect { subject }.to change(Like, :count).by(1)
      expect(user.likes.count).to eq 1
      expect(assigns(:likes_from_user).any?).to eq true
    end

    it 'redirects to user page' do
      subject
      expect(response).to redirect_to user_post_path(post.user, post)
    end

    it 'assignes like to current user' do
      subject
      expect(assigns(:likes_from_user).first.user).to eq user
    end

    context 'when user tries to remove someones like' do
      let!(:like) { create :like, user: create(:user) }
      let(:params) { {id: like.id, user_id: user, post_id: post }}
      it 'does not delete the like' do
        subject
        expect { subject }.to_not change(user.likes, :count)
      end
    end
  end
end
