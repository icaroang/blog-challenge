class Post::Contract
  class Create < Reform::Form
    property :title
    property :markdown_body

    validates :title, :markdown_body, presence: true
  end
end