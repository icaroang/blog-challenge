require 'rails_helper'
RSpec.describe MarkdownParserJob, type: :worker do
  describe "#perform"
    it "calls Markdown::Operation::Parser" do
      # TODO: expect markdown operation be called
    end
  end
end
