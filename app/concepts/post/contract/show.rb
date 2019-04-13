module Post::Contract
  class Show < Reform::Form
    validate :can_be_show?

    def can_be_show?
      return if model.html_body.present?
      errors.add(:base, "não pode ser visualizada")
    end
  end
end