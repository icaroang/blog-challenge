module Post::Operation
  class Index < Trailblazer::Operation
    step :models

    # Returns only posts with html_body
    def models(options, params:, **)
      options["models"] = Post.where.not(html_body: nil)
    end
  end
end