## Cucumber + Ruby Tests

### Gems used

All gems used in this project can be found in [Gemfile](https://github.com/thespecial/onliner/blob/master/Gemfile):

- [Cucumber](https://github.com/cucumber/cucumber) - BDD tool
- [Dotenv](https://github.com/bkeepers/dotenv) - to manage environment variables
- [page-object](https://github.com/cheezy/page-object) - to create page objects
- [parallel_tests](https://github.com/grosser/parallel_tests) - to run tests in parallel
- [Rake](https://github.com/ruby/rake) - to specify tasks
- [ReportBuilder](https://github.com/rajatthareja/ReportBuilder) - to generate test reports
- [RSpec Expectations](https://github.com/rspec/rspec-expectations) - to express expectations better
- [RuboCop](https://github.com/bbatsov/rubocop) - to keep Ruby code standarts
- [selenium-webdriver](https://github.com/SeleniumHQ/selenium/tree/master/rb) - to act with browser
- [Watir-Nokogiri](http://www.rubydoc.info/gems/watir-nokogiri/1.0.0) - work with HTML on the webpage 

### Files structure

Developed framework has following file structure:

**сonfig**
  - `config.yml` - contains initial params for tests running, e.g. browser, screen size, headless. 

**features**
  - **pages**
    - **sections** - contains page objects for page sections
      - `cart_product.rb` - in cart product object
      - `header.rb` - header object
      - `product_suggestion.rb` - product suggestion object on product view page
      - `product_suggestions.rb` - has many instances of ProductSuggestion
    - `home_page.rb` - homepage page object
    - `cart_page.rb` - cart page object
    - `product_page.rb` - product view page object
  - **step_definitions** - this folder contains cucumber step definitions
    - `cart_steps.rb` - steps related to cart page actions are defined here
    - `product_view_steps.rb` - steps related to product page actions are defined here
    - `search_steps.rb` - steps related to product search actions
  - **support**
    - `constants.rb` - constants required in tests
    - `env.rb` - place where tests start runnig
    - `selectors.rb` - page selector constants
  - `search_and_add_to_cart.feature` - cucumber feature file to describe feature and scenarios

**reports** - `report<n>.json` and `index.html` report files are placed here

  
