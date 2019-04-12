class MarkdownParserJob
  include Sidekiq::Worker

  def perform(post_id)
    Markdown::Operation::Parser.({ id: post_id })
  end
end
