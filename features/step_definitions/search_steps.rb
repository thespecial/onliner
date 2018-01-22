# frozen_string_literal: true

# Given a web browser at OnlinerBy homepage
Given(/^a web browser at OnlinerBy homepage$/) do
  visit HomePage
end

# When user enters <smth> into the search field
# When I type <smth> into the search field
# When User type <smth> into the
When(/^(?:I|(?:U|u)ser) (?:enters?|types?) "([^"]*)" into the search(?: field)?$/) do |product_name|
  on(Header).search_field = product_name
end

# Then search results for <smth> are shown
# Then search results for <smth> should be shown
Then(/^search results(?: for)?(?: )?(?:"([^"]*)")?(?: are| should be) shown$/) do |product_name|
  on SearchModal do |modal|
    modal.switch_to_frame
    modal.wait_for_results_to_load

    expect(modal.search_field).to eq product_name unless product_name.nil?
    expect(modal.results_elements.length).to be_positive
  end
end
