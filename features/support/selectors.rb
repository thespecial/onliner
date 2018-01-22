# frozen_string_literal: true

# Selectors required across tests
module Selectors
  # Header
  HEADER ||= {
    self: { xpath: '//header[@class="g-top"]' },
    cart: { xpath: '//a[@class="b-top-navigation-cart__link"]' },
    input: { xpath: '//div[@id="fast-search"]//input[@name="query"]' }
  }.freeze

  # Fast search modal
  FAST_SEARCH_MODAL ||= {
    wrapper: { xpath: '//div[@id="fast-search-modal"]' },
    iframe: { xpath: '//div[@id="fast-search-modal"]//iframe[@class="modal-iframe"]' },
    searchbar: {
      self: { xpath: '//div[@id="search-page"]//div' },
      input: { xpath: '//div[@id="search-page"]//input[@class="search__input"]' },
    },
    result: {
      self: { xpath: '//div[@id="search-page"]//li[@class="search__result"]' },
      title: { class: 'product__title-link' },
      price: { class: 'product__price' }
    }
  }.freeze

  # Product page
  PRODUCT_PAGE ||= {
    title: { xpath: '//h1[@class="catalog-masthead__title"]' },
    suggestions: {
      self: { xpath: '//aside[@class="product-aside"]' },
      top: { xpath: '//div[contains(@class, "product-aside__item--highlighted")]' },
      others: { xpath: '//div[contains(@class, "product-aside__item--ordinary")]//div[@class="product-aside__item-i"]' },
      buttons: {
        add_to_cart: { class: 'product-aside__item-button' },
        added_to_cart: { class: 'product-aside__item-button_checked' }
      }
    },
    specs: { xpath: '//table[@class="product-specs__table"]' }
  }.freeze

  # Cart page
  CART_PAGE ||= {
    title: { xpath: '//h1[@class="cart-header__title"]' },
    summary: { xpath: '//div[@class="cart-navigation__sum"]' },
    product: {
      self: { xpath: '//div[@class="cart-product"]' },
      title: { class: 'cart-product-title' },
      count: { class: 'cart-product-add-box__input' }
    }
  }.freeze
end
