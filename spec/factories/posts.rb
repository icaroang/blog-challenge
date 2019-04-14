FactoryBot.define do
  factory :post do
    title { "Post test" }
    markdown_body  { "## **markdown body**" }
    user
  end

  factory :post_with_html_body, class: Post do
    title { "Post test" }
    markdown_body  { "## **markdown body**" }
    html_body  { "<h2><strong>markdown body</strong></h2>" }
    user
  end
end