require 'rails_helper'

describe "Post management" do
  describe "create" do
    context "when user is logged" do
      let(:user) { create(:user) }
      before { login_as(user, :scope => :user) }

      it 'creates post with success' do
        visit 'posts/new'

        within("#new_post") do
          fill_in 'post_title', with: 'integration test'
          fill_in 'post_markdown_body', with: '**integration test****'
        end
        click_button 'Salvar'

        expect(page).to have_content('Postagem criada com sucesso.')
      end
    end

    context "when user is not logged" do
      it "requires sign in or sign up" do
        visit 'posts/new'

        expect(page).to have_content('You need to sign in or sign up before continuing.')
      end
    end
  end

  describe "update" do
    let(:post) { create(:post_with_html_body) }

    context "when user is logged" do
      let(:user) { create(:user) }
      before { login_as(user, :scope => :user) }

      it 'updates post with success' do
        visit "posts/#{post.id}/edit"

        within(".edit_post") do
          fill_in 'post_title', with: 'Update integration test'
          fill_in 'post_markdown_body', with: '**update integration test**'
        end
        click_button 'Salvar'

        expect(page).to have_content('Postagem atualizada com sucesso.')
      end
    end

    context "when user is not logged" do
      it "requires sign in or sign up" do
        visit "posts/#{post.id}/edit"        

        expect(page).to have_content('You need to sign in or sign up before continuing.')
      end
    end
  end

  describe "view" do
    context "when post can be show" do
      let(:post) { create(:post_with_html_body) }

      it "shows html body" do
        visit "posts/#{post.id}"

        expect(page).to have_content("markdown body")
      end
    end

    context "when post can not be show" do
      let(:post) { create(:post) }

      it "redirects to posts_path" do
        visit "posts/#{post.id}"

        expect(page).to have_current_path(posts_path)
        expect(page).to have_content('Não foi possível visualizar esta postagem.')
      end
    end
  end
end