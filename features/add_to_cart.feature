Feature: Add Product to Cart
  As a user
  I should be able to:
    - search product
    - view product specs
    - add product to cart
    - see products in cart

  Scenario: Search product, check specs and add to cart
    Given a web browser at OnlinerBy homepage
    When user enters "Canon EOS 1300D" into the search field
    Then search results for "Canon EOS 1300D" are shown

    When user clicks on the first result
    Then product "Canon EOS 1300D" page should be opened
    And product specifications are shown:
      | screen | sensor             | megapixels |
      | 3 ''   | "APS-C (1.6 crop)" | "18 Мп"    |

    When cart is empty
    And user adds product to cart
    Then cart shows one product in header

    When user opens cart page
    Then cart has one product on the page
    And product in the cart is:
      | title             | count |
      | "Canon EOS 1300D" |     1 |


  Scenario: Search and add couple products to cart
    Given a web browser at OnlinerBy homepage
    When I type "Canon EOS 1300D" into the search
    Then search results are shown

    When I click on the first result
    Then product "Canon EOS 1300D" page should be opened

    When cart is empty
    And I add product to cart
    Then cart shows 1 product in header

    When I type "Canon EOS 750D Kit 18-55mm" into the search
    Then search results are shown

    When I click on the first result
    Then product "Canon EOS 750D Kit 18-55mm" page should be opened

    When I add product to cart
    Then cart has 2 products in header

    When I navigate to the Cart page
    Then cart has 2 products
    And products in the cart are:
      | title                           | count |
      | "Canon EOS 1300D"               |     1 |
      | "Canon EOS 750D Kit 18-55mm""   |     1 |
