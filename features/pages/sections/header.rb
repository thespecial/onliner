# frozen_string_literal: true

# Header page oject
class Header
  include PageObject

  link(:cart, Selectors::HEADER[:cart])
  text_field(:search_field, Selectors::HEADER[:input])

  # Get cart items count displayed in header
  def cart_items_count
    cart_element.when_visible.text.to_i
  end
end
