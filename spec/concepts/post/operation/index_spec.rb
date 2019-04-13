require 'rails_helper'

describe Post::Operation::Index do
  let!(:post1) { create(:post) }
  let!(:post2) { create(:post_with_html_body) }
  let!(:post3) { create(:post_with_html_body) }
  let!(:post4) { create(:post_with_html_body) }

  let(:call_operation) { described_class.() }

  it "returns only posts with html_body" do
    result = call_operation
    expect(result["models"].to_ary).to eql([post2, post3, post4])
    expect(result["models"].to_ary).to_not include([post1])
  end
end