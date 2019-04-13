module Post::Operation
  class Show < Trailblazer::Operation
    step :model
    step Contract::Build(constant: Post::Contract::Show)
    step Contract::Validate()

    def model(options, params:, **)
      options["model"] = Post.find_by(id: params[:id])
    end
  end
end