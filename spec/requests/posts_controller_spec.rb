require 'rails_helper'

RSpec.describe PostsController do
  let(:user) { create :user}
  before {sign_in user}
  describe 'POST /posts' do
    context "when posting a status update" do
      it 'can post the status if all data is valid' do
        expect {
          post '/posts', params: { post: {
            postable_type: 'Status',
            status_text: 'Hello friends!'
          } }
        }.to change {
          user.posts.reload.count
        }.from(0).to(1)
        expect(response).to redirect_to timelines_path
        follow_redirect!
        expect(response.body).to include 'Hello friends!'
      end
    end
  end
end
