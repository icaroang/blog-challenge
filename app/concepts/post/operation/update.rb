module Post::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model
      step Contract::Build(builder: :contract_builder)      

      def model(options, params:, **)
        options["model"] = Post.find_by(id: params[:id])
      end

      def contract_builder(options, model:, **)
        Post::Contract::Update.new(model)
      end
    end

    step Nested(Present)
    step Contract::Validate()
    step Contract::Persist()
    success :schedule_markdown_parser_job

    def schedule_markdown_parser_job(options, model:, **)
      MarkdownParserJob.perform_async(model.id)
    end
  end
end