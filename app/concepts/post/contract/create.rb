class Post::Contract
  class Create < Reform::Form
    property :title
    property :markdown_body

  end
end