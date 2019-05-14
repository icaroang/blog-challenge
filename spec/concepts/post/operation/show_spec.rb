require 'rails_helper'

describe Post::Operation::Show do
  let(:call_operation) { described_class.(params) }
  let(:params) { { id: post.id } }
  
  describe "with success" do
    context "when html_body is present" do
      let(:post) { create(:post_with_html_body) }

      it "returns success result" do
        result = call_operation
        expect(result).to be_success
      end
    end
  end

  describe "without success" do
    context "when html_body isn't present" do
      let(:post) { create(:post) }

      it "returns failure result" do
        result = call_operation
        expect(result).to be_failure
      end
    end
  end

  describe "validations" do
    let(:errors) { call_operation["contract.default"].errors }

    describe "can_be_show?" do
      context "when html_body isn't present" do
        let(:post) { create(:post) }
        it "adds error" do
          expect(errors[:base]).to include("não pode ser visualizado")
        end
      end
    
      context "when html_body is present" do
        let(:post) { create(:post_with_html_body) }
        
        it "doesn't add error" do
          expect(errors[:base]).to_not include("não pode ser visualizado")
        end
      end
    end
  end

end