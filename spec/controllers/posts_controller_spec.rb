require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "#index" do
    let!(:post1) { create(:post_with_html_body) }
    let!(:post2) { create(:post_with_html_body) }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @posts" do
      get :index
      expect(assigns(:posts).to_ary).to eql([post1, post2])
    end
  end
end
