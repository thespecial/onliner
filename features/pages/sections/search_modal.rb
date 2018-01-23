# frozen_string_literal: true

# Search modal page object
class SearchModal
  include PageObject

  div(:searchbar, Selectors::FAST_SEARCH_MODAL[:searchbar][:self])
  div(:wrapper, Selectors::FAST_SEARCH_MODAL[:wrapper])
  list_items(:results, Selectors::FAST_SEARCH_MODAL[:result][:self])
  text_field(:search_field, Selectors::FAST_SEARCH_MODAL[:searchbar][:input])

  # Return prepared hash of search results data
  def prepared_results
    prepared = []
    results = WatirNokogiri::Document.new(html).lis(Selectors::FAST_SEARCH_MODAL[:result][:self])

    results.each { |result| prepared[] = { title: title(result), price: price(result) } }

    prepared
  end

  # Switch to iframe context
  #
  # Required because of geckodriver issue:
  #   "ERROR: Command execution failure. The error message is: can't access dead object".
  def switch_to_frame
    wait.until { wrapper_element.attribute('class').include?('modal_open') }
    @browser.switch_to.frame(@browser.find_element(Selectors::FAST_SEARCH_MODAL[:iframe]))
  end

  # Switch back to page context
  #
  # Required because of geckodriver issue:
  #   "ERROR: Command execution failure. The error message is: can't access dead object".
  def switch_to_default_content
    @browser.switch_to.default_content
  end

  # Waits until searchbar loading starts and stops
  # Signalize that search results finished loading
  # Wrapped with rescue as initial loading may not appear
  def wait_for_results_to_load
    wait_until { searchbar_element.attribute('class').include?(Constants::SEARCHING_CLASS) }
  rescue StandardError
    puts 'Loading in search modal didn\'t appear!'
  ensure
    wait_until { !searchbar_element.attribute('class').include?(Constants::SEARCHING_CLASS) }
  end

  private

  # Get price from search result
  def price(result)
    tmp = /(?<price>\d+,\d+)/.match(result.div(Selectors::FAST_SEARCH_MODAL[:result][:price]).text)
    !tmp.nil? ? tmp[:price].to_f : 0
  end

  # Get title from search result
  def title(result)
    result.link(Selectors::FAST_SEARCH_MODAL[:result][:title]).text
  end
end
