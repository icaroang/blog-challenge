require 'rails_helper'
require 'shared_examples/validates_presence_of'

describe Post::Operation::Update do
  let(:post) { create(:post) }
  let(:call_operation) { described_class.(params) }

  describe "with success" do
    context "when passing valid params" do
      let!(:params) do
        {
          id: post.id,
          title: 'Post update',
          markdown_body: '## **markdown body update**'
        }
      end

      it "returns success result" do
        result = call_operation
        expect(result).to be_success
      end
      
      it "updates post" do
        expect(post.title).to eql("Post test")
        expect(post.markdown_body).to eql("## **markdown body**")
        call_operation
        expect(post.reload.title).to eql("Post update")
        expect(post.reload.markdown_body).to eql("## **markdown body update**")
      end

      it "schedules the markdown parser job" do
        expect(MarkdownParserJob).to receive(:perform_async).with(post.id).and_call_original
        call_operation
      end
    end
  end

  describe "without success" do
    context "when passing invalid params" do
      let!(:params) do
        {
          id: post.id,
          title: '', # Set invalid title
          markdown_body: '## **markdown body**'
        }
      end

      it "returns failure result" do
        result = call_operation
        expect(result).to be_failure
      end
      
      it "doesn't update post" do
        expect(post.title).to eql("Post test")
        expect(post.markdown_body).to eql("## **markdown body**")
        call_operation
        expect(post.reload.title).to eql("Post test")
        expect(post.reload.markdown_body).to eql("## **markdown body**")
      end

      it "doesn't schedule the markdown parser job" do
        expect(MarkdownParserJob).to_not receive(:perform_async).and_call_original
        call_operation
      end
    end
  end

  describe "validations" do
    let!(:params) do
      {
        id: post.id
      }
    end
    let(:errors) { call_operation["contract.default"].errors }

    it_behaves_like "validates_presence_of",
      title: "Post update test",
      markdown_body: "## **markdown update body**"
  end
end