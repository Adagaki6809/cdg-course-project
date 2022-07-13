require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create :user }
  let(:post) { create :post, user: user }
  before do
    sign_in user 
    request.env['HTTP_REFERER'] = 'posts/'
  end

  describe '#index' do
    subject { process :index, params: params }
    let(:params) { { user_id: user, post_id: post } }
    let(:comments) { create_list(:comment, 5) }

    it 'assigns @comments' do
      subject
      expect(assigns(:comments)).to eq comments
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
    let(:comment) { create(:comment, user: user, post: post) }
    let(:params) { { comment: attributes_for(:comment), user_id: user, post_id: post } }

    it 'creates a comment' do
      expect { subject }.to change(Comment, :count).by(1)
    end

    it 'redirects to user page' do
      subject
      expect(response).to redirect_to user_post_path(post.user, post)
    end

    it 'assignes comment to current user' do
      subject
      expect(assigns(:comment).user).to eq user
    end
  end
end
