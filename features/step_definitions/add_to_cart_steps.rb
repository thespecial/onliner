# frozen_string_literal: true

# When cart is empty
# When cart has no|one|<int> product(s)
# When cart shows no|one|<int> item(s)
# When cart shows no|one|<int> product(s) in header
# When cart shows no|one|<int> item(s) on the page
When(/^cart (?:is empty|(?:has|shows) (\d+|no|one))(?: items?| products?)?(?: in header| on the page)?$/) do |count|
  expected_count = case count
                   when 'no' then 0
                   when 'one' then 1
                   else count.to_i
                   end

  if @current_page.instance_of?(CartPage)
    quantity = on(CartPage).summary(:products_count)

    expect(quantity).to eq expected_count
    expect(quantity).to eq on(CartPage).total_products_count
  else
    expect(on(Header).cart_items_count).to eq expected_count
  end
end

# When user adds item to cart
# When I add product to the cart
When(/^(?:I|(?:U|u)ser) adds? (?:item|product) to(?: the)? cart$/) do
  on(ProductPage) do |page|
    cart_products_before_count = on(Header).cart_items_count
    page.add_top_suggestion_to_cart
    wait.until { on(Header).cart_items_count == cart_products_before_count + 1 }
  end
end

# When I open cart page
# When user opens cart page
# When I navigate to cart
# When user navigates to cart
When(/^(?:I|(?:U|u)ser) (?:opens?|navigates? to)(?: the)?(?: )?(?:C|c)art(?: page)?$/) do
  on(Header).cart

  on CartPage do |cart|
    expect(current_url).to match(Constants::CART_PAGE[:url])
    expect(cart.title).to eq(Constants::CART_PAGE[:title])
  end
end

# Then products in the cart are:
# Then item in the cart is:
Then(/^(?:products?|items?) in(?: the)?(?: )?cart (?:is|are)(?: following)?:$/) do |products|
  products = products.hashes.map { |product| Hash[product.map { |k, v| [k.to_sym, v.delete('"')] }] }

  on CartPage do |cart|
    products.each_index do |i|
      cart_product = cart.product(i)
      expect(cart_product[:title]).to include(products[i][:title])
      expect(cart_product[:count]).to eq products[i][:count].to_i
    end
  end
end
