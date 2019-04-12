FactoryBot.define do
  factory :post do
    title { "Post test" }
    markdown_body  { "'## **markdown body**" }
  end
end