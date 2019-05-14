module Post::Contract
  class Update < Reform::Form
    include Post::Contract::Concerns::Common
  end
end
