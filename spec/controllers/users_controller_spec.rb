require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }
  before { sign_in user }

  describe '#index' do
    subject { process :index }

    let(:users) { create_list(:user, 2) }
    it 'renders the index template' do
      subject
      expect(response).to render_template :index
    end

    context 'when user is not logged in' do
      before { sign_out user }
      it 'redirects to the sign in page' do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#new' do
    subject { process :new }
    it 'assigns @user' do
      subject
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe '#show' do
    subject { process :show, params: { id: user.id } }
    it 'redirects to users posts page' do
      subject
      expect(response).to redirect_to user_posts_path(assigns(:user))
    end
  end
end
