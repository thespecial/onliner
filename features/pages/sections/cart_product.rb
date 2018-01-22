# frozen_string_literal: true

# Cart product page object
class CartProduct
  include PageObject

  div(:title, Selectors::CART_PAGE[:product][:title])
  text_field(:count, Selectors::CART_PAGE[:product][:count])
end
