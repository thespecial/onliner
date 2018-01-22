# frozen_string_literal: true

# Product suggestions page object
class ProductSuggestions
  include PageObject

  # Top (possibly best) suggestion on product page
  page_section(
    :top,
    ProductSuggestion,
    Selectors::PRODUCT_PAGE[:suggestions][:top]
  )

  # Other suggestions, placed under top suggestion
  page_sections(
    :others,
    ProductSuggestion,
    Selectors::PRODUCT_PAGE[:suggestions][:others]
  )
end
