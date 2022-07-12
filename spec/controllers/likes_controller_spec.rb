require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create :user }
  let(:post) { create :post, user: create(:user) }
  before do
    sign_in user 
    request.env['HTTP_REFERER'] = 'posts/'
  end

  describe '#index' do
    subject { process :index, params: params }
    let(:params) { { user_id: user.id, post_id: post.id } }
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

    let(:params) { { like: attributes_for(:like), user_id: user.id, post_id: post.id } }

    it 'creates a like' do
      expect(user.likes.count).to eq 0
      expect { subject }.to change(Like, :count).by(1)
      expect(user.likes.count).to eq 1
    end

    it 'redirects to user page' do
      subject
      expect(response).to redirect_to user_post_path(post.user, post)
    end

    it 'assignes like to current user' do
      subject
      expect(assigns(:likes_from_user).first.user).to eq user
    end

    context 'when like was already on post' do
      it 'deletes the like' do
        expect(user.likes.count).to eq 0
        expect { subject }.to change(Like, :count).by(1)
        expect(user.likes.count).to eq 1
      end
    end
  end
end
