require 'rails_helper'

describe Markdown::Operation::Parser do
  let(:post) { create(:post) }
  let(:call_operation) { described_class.(params) }
  let(:params) { { id: post.id } }

  describe "with success" do
    it "returns success result" do
      result = call_operation
      expect(result).to be_success
    end

    it "saves html_content" do
      call_operation
      expect(post.reload.html_body).to eql("<h2><strong>markdown body</strong></h2>\n")
    end
  end

  describe "without success" do
    context "when not found post" do
      let(:params) { { id: 0 } }

      it "returns failure result" do
        result = call_operation
        expect(result).to be_failure
      end

      it "doesn't save html_content" do
        call_operation
        expect(post.reload.html_body).to eql(nil)
      end
    end
  end
end