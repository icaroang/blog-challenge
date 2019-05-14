require 'rails_helper'
RSpec.describe MarkdownParserJob, type: :worker do
  describe "#perform" do
    let(:post) { create(:post) }
    let(:params) { { id: post.id } }

    it "calls Markdown::Operation::Parser" do
      expect(Markdown::Operation::Parser).to receive(:call).with(params)
      subject.perform(post.id)
    end
  end
end
