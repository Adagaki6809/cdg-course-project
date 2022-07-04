require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }
  before { sign_in user }

  describe '#index' do
    subject { process :index, method: :get, params: params }
    let(:params) { { post: attributes_for(:post) } }

    let(:posts) { create_list(:post, 5) }
    it 'renders the index template' do
      subject
      expect(response).to render_template :index
    end
  end
end
