# frozen_string_literal: true

# Some constants required in tests
module Constants
  # Base URL
  BASE_URL ||= 'https://www.onliner.by'

  CART_PAGE ||= {
    title: 'Корзина',
    url: /^(?:https?:\/\/)cart.onliner.by\/$/,
    summary: /^Итого: (?<products_count>\d+) товар(?:ов|а)? на сумму (?<price>\d+,\d+) р.$/
  }.freeze

  # To check results are loaded
  SEARCHING_CLASS ||= 'search__bar_searching'

  PRODUCT_PAGE ||= {
    url: /^(?:https?:\/\/)catalog.onliner.by\/.+/,
    specs: {
      screen: { text: /Размер экрана/ },
      sensor: { text: /Физический размер матрицы/ },
      megapixels: { text: /Количество точек матрицы/ }
    },
    suggestions: {
      hovered: /left: 137px;/ # Criteria to wait suggestion animation
    }
  }.freeze
end
