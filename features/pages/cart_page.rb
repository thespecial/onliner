# frozen_string_literal: true

# Cart view page object
class CartPage
  include PageObject

  h1(:title, Selectors::CART_PAGE[:title])
  div(:summary, Selectors::CART_PAGE[:summary])

  page_sections(
    :products,
    CartProduct,
    Selectors::CART_PAGE[:product][:self]
  )

  # Total products count.
  #
  # For example, there are 2 products - product_1 and product_2.
  # 2 items of product_1 and 5 items of product_2 are added to the cart.
  # So total count is calculated by sum of products quantities, e.g. 2 + 5 = 7
  def total_products_count
    products.inject(0) { |count, product| count + product.count.to_i }
  end

  # Get values (price, products count) from cart summary text
  def summary(param)
    extract_values_from_cart_summary[param]
  end

  # Get single cart product title and count
  def product(index)
    {
      title: products[index].title,
      count: products[index].count.to_i
    }
  end

  private

  # Extract products quantity and price from summary text
  def extract_values_from_cart_summary
    result = Constants::CART_PAGE[:summary].match(summary_element.when_visible.text)

    {
      products_count: result[:products_count].to_i,
      price: result[:price].to_i
    }
  end
end
