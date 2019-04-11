require 'rails_helper'

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
    # TODO: test failures
  end

  describe "validations" do
    # TODO: test all validations
  end
end