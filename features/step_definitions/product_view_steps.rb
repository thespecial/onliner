# frozen_string_literal: true

# When user clicks on the first|last|<int>st|<int>nd product
# When I click on first|last|<int>st|<int>nd result
When(/^(?:I|(?:U|u)ser) clicks? on (?:the)?(?: )?(\d+|first|last)(?:st|nd)? (?:product|result)$/) do |index|
  index = case index
          when 'first' then 0
          when 'last' then -1
          else (index.to_i - 1)
          end

  on SearchModal do |modal|
    modal.results_elements[index].click
    modal.switch_to_default_content
  end
end

# Then product <product> view page should be opened
# Then product <product> page should be opened
Then(/^product "([^"]*)" (?:view)?(?: )?page should be opened$/) do |product_name|
  expect(on(ProductPage).title).to include(product_name)
  expect(current_url).to match(Constants::PRODUCT_PAGE[:url])
end

# Then product specifications are shown:
# Then product specs are shown:
Then(/^product (?:specifications|specs) are shown:$/) do |table|
  specs = table.hashes.first
  specs = specs.map { |k, str| [k.to_sym, str.delete('"')] }.to_h

  expect(on(ProductPage).details).to eq specs
end
