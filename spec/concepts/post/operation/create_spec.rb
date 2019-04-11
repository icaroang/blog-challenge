require 'rails_helper'
require 'shared_examples/validates_presence_of'

describe Post::Operation::Create do
  let(:call_operation) { described_class.(params) }

  describe "with success" do
    context "when passing valid params" do
      let!(:params) do
        {
          title: 'Post test',
          markdown_body: '## **markdown body**'
        }
      end

      it "returns success result" do
        result = call_operation
        expect(result).to be_success
      end
      
      it "creates post" do
        expect { call_operation }.to change(Post, :count).by(1)
      end

      xit "schedules the markdown parser job" do
      end
    end
  end

  describe "without success" do
    context "when passing invalid params"
    let!(:params) do
      {
        title: '', # Set invalid title
        markdown_body: '## **markdown body**'
      }
    end

    it "returns failure result" do
      result = call_operation
      expect(result).to be_failure
    end
    
    it "doesn't create post" do
      expect { call_operation }.to change(Post, :count).by(0)
    end

    xit "doesn't schedule the markdown parser job" do
    end
  end

  describe "validations" do
    let!(:params) do
      {
        title: 'Post test',
        markdown_body: '## **markdown body**'
      }
    end
    let(:errors) { call_operation["contract.default"].errors }

    it_behaves_like "validates_presence_of",
      title: "Post test",
      markdown_body: "## **markdown body**"
  end
end