module Markdown::Operation
  class Parser < Trailblazer::Operation
    step :model
    step :parse_markdown
    step :save_result!

    def model(options, params:, **)
      options["model"] = Post.find_by(id: params[:id])
    end

    def parse_markdown(options, model:, **)
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
      options["html_result"] = markdown.render(model.markdown_body)
    end

    def save_result!(options, model:, html_result:, **)
      model.html_body = html_result
      model.save!
    end
  end
end