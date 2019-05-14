module Post::Contract
  class Create < Reform::Form
    include Post::Contract::Concerns::Common
  end
end