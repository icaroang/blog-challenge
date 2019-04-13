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
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe "#new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "assigns @form and @model" do
      get :new
      expect(assigns(:form)).to be_an_instance_of(Trailblazer::Rails::Form)
      expect(assigns(:model)).to be_a_new(Post)
    end
    
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")      
    end
  end
  
  describe "#create" do
    let(:post_model) { create(:post) }

    context "with success" do
      let(:params) do
        {
          title: post_model.title,
          markdown_body: post_model.markdown_body
        }
      end
      
      it "redirects to posts_path" do
        post :create, params: { post: params }
        expect(response).to redirect_to(posts_path)
      end

      it "sets flash success message" do
        post :create, params: { post: params }
        expect(flash[:success]).to eql('Postagem criada com sucesso.')
      end
    end
    
    context "with failure" do
      let(:params) do
        {
          title: '', # Set some invalid title
          markdown_body: post_model.markdown_body
        }
      end
      
      it "renders the new template" do
        post :create, params: { post: params }
        expect(response).to render_template('new')
      end

      it "sets flash notice message" do
        post :create, params: { post: params }
        expect(flash[:notice]).to eql('Não foi possível criar a postagem.')
      end
    end
  end

  describe "#edit" do
    let(:post) { create(:post_with_html_body) }
    let(:params) { { id: post.id } }

    it "returns http success" do
      get :edit, params: params
      expect(response).to have_http_status(:success)
    end
    
    it "assigns @form and @model" do
      get :edit, params: params
      expect(assigns(:form)).to be_an_instance_of(Trailblazer::Rails::Form)
      expect(assigns(:model)).to be_a(Post)
    end
    
    it "renders the edit template" do
      get :edit, params: params
      expect(response).to render_template("edit")      
    end
  end

  describe "#update" do
    let(:post) { create(:post) }

    context "with success" do
      let(:params) do
        {
          id: post.id,
          post: {
            title: "Update title"
          }
        }
      end

      it "redirects to post view" do
        put :update, params: params
        expect(response).to redirect_to(post_path(post))
      end

      it "sets flash success message" do
        put :update, params: params
        expect(flash[:success]).to eql('Postagem atualizada com sucesso.')
      end
    end

    context "with failure" do
      let(:params) do
        {
          id: post.id,
          post: {
            title: "" # Set some invalid param
          }
        }
      end

      it "renders the edit template" do
        put :update, params: params
        expect(response).to render_template('edit')
      end

      it "sets flash notice message" do
        put :update, params: params
        expect(flash[:notice]).to eql('Não foi possível atualizar a postagem.')
      end
    end
  end

  describe "#show" do
    context "with success" do
      let(:post) { create(:post_with_html_body) }
      let(:params) { { id: post.id } }

      it "returns http success" do
        get :show, params: params
        expect(response).to have_http_status(:success)
      end
      
      it "assigns @form and @model" do
        get :show, params: params
        expect(assigns(:form)).to be_an_instance_of(Trailblazer::Rails::Form)
        expect(assigns(:model)).to be_a(Post)
      end
      
      it "renders the show template" do
        get :show, params: params
        expect(response).to render_template("show")      
      end
    end

    context "with failure" do
      let(:post) { create(:post) }
      let(:params) { { id: post.id } }

      it "redirects to posts_path" do
        get :show, params: params        
        expect(response).to redirect_to(posts_path)
      end

      it "sets flash notice message" do
        get :show, params: params        
        expect(flash[:notice]).to eql('Não foi possível visualizar esta postagem.')
      end
    end
  end
end
