# frozen_string_literal: true

# Product view page object
class ProductPage
  include PageObject

  h1(:title, Selectors::PRODUCT_PAGE[:title])
  table(:specs, Selectors::PRODUCT_PAGE[:specs])

  # There is suggestions section on product page - one top and others
  page_section(
    :suggestions,
    ProductSuggestions,
    Selectors::PRODUCT_PAGE[:suggestions][:self]
  )

  # Get some of product details
  def details
    @specs = WatirNokogiri::Document.new(specs_element.html).table

    {
      screen: spec(Constants::PRODUCT_PAGE[:specs][:screen]),
      sensor: spec(Constants::PRODUCT_PAGE[:specs][:sensor]),
      megapixels: spec(Constants::PRODUCT_PAGE[:specs][:megapixels])
    }
  end

  # Add top suggestion to cart
  def add_top_suggestion_to_cart
    add_to_cart(suggestions.top)
  end

  # Add other suggestions to cart (by index)
  def add_other_suggestion_to_cart(index)
    add_to_cart(suggestions.others[index], :other)
    title_element.hover # To unhover suggestion
    wait_until { !suggestion.hovered? && suggestion.added_to_cart? }
  end

  private

  # Returns spec by label and remove unnecessary &nbsp;
  def spec(label)
    nbsp = Nokogiri::HTML('&nbsp;').text
    @specs.row(label)[1].text.gsub(nbsp, ' ')
  end

  # Add suggestion to cart
  def add_to_cart(suggestion, type = nil)
    open_suggestion(suggestion) if type == :other
    suggestion.add_to_cart_element.when_visible.click
    wait_until { suggestion.added_to_cart_element.visible? }
  end

  # Hovers "other" suggestion to make 'Add to cart' button visible
  def open_suggestion(suggestion)
    suggestion.hover
    wait_until { suggestion.hovered? }
  end
end
