class MarkdownParserJob
  include Sidekiq::Worker

  def perform(post_id)
    # TODO: call Markdown parser operation
  end
end
