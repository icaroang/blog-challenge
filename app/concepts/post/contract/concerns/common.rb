module Post::Contract::Concerns
  module Common
    include Reform::Form::Module

    property :title
    property :markdown_body
    property :user

    validates :title, :markdown_body, presence: true
  end
end