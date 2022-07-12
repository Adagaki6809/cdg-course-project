require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }
  before { sign_in user }
  describe '#index' do
    subject { process :index, params: params }
    let(:params) { { user_id: user.id } }
    #let(:params2) { { post: attributes_for(:post), user_id: user.id } }
    let(:posts) { create_list(:post, 5, user: user) }
    it 'renders the index template' do
      subject
      expect(response).to render_template :index
    end

    it 'assigns @posts' do
      subject
      expect(assigns(:posts)).to eq posts
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

    let(:params) { { post: attributes_for(:post), user_id: user.id } }
    
    it 'creates a post' do
      expect { subject }.to change(Post, :count).by(1)
    end

    it 'redirects to user page' do
      subject
      expect(response).to redirect_to user_path(user)
    end

    it 'assignes post to current user' do
      subject
      expect(assigns(:post).user).to eq user
    end
  end
end
