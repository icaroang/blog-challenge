module Post::Contract::Concerns
  module Common
    include Reform::Form::Module

    property :title
    property :markdown_body
    property :current_user, virtual: true

    validates :title, :markdown_body, presence: true
  end
end