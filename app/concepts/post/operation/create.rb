module Post::Operation
  class Create < Trailblazer::Operation
    class New < Trailblazer::Operation
      step :model!
      step Contract::Build(builder: :contract_builder)

      def model!(options, **)
        options["model"] = Post.new
      end

      def contract_builder(options, model:, **)
        Post::Contract::Create.new(model)
      end
    end

    step Nested(New)
    step Contract::Validate()
    step Contract::Persist()
    success :schedule_markdown_parser_job

    def schedule_markdown_parser_job(options, model:, **)
      MarkdownParserJob.perform_async(model.id)
    end
  end
end