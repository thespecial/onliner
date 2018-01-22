# frozen_string_literal: true

# Product suggestion page object
class ProductSuggestion
  include PageObject

  link(
    :add_to_cart,
    Selectors::PRODUCT_PAGE[:suggestions][:buttons][:add_to_cart]
  )

  link(
    :added_to_cart,
    Selectors::PRODUCT_PAGE[:suggestions][:buttons][:added_to_cart]
  )

  # Check if suggestion is hovered
  def hovered?
    wait_until do
      Constants::PRODUCT_PAGE[:suggestions][:hovered].match(attribute('style'))
    end
  end

  # Check if suggestion is added to cart by added button appearing
  def added_to_cart?
    added_to_cart_element.visible?
  end
end
