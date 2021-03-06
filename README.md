## Cucumber + Ruby Tests

### Demo

[Scenarios](https://github.com/thespecial/onliner/blob/master/features/search_and_add_product_to_cart.feature)

**Tests execution**

| Sequential | Parallel |
|------------|----------|
|![tests](https://user-images.githubusercontent.com/3316019/35257100-720268a4-0008-11e8-9406-c5bc96a6dd41.gif) | ![tests_parallel](https://user-images.githubusercontent.com/3316019/35257099-71e4d5b4-0008-11e8-974b-3034e914ede3.gif) |

NOTE: For parallel execution reports functionality is not demonstrated, but work exactly the same as for sequential.

**Reports**

| Overview  | Features | Summary |
|-----------|----------|-----------|
|![screen shot 2018-01-23 at 06 11 54](https://user-images.githubusercontent.com/3316019/35256343-71fdf3d6-0004-11e8-8f73-34438f875d7b.png)| ![screen shot 2018-01-23 at 06 12 10](https://user-images.githubusercontent.com/3316019/35256342-71e13692-0004-11e8-955e-9a263cc694bd.png) | ![screen shot 2018-01-23 at 06 12 25](https://user-images.githubusercontent.com/3316019/35256341-71c31cc0-0004-11e8-8fcc-8ab59f8e20d6.png) |

### Requirements

- Ruby 2.5.0
- Chromedriver (to run tests in Chrome)
- Geckodriver (to run tests in Firefox)

To install dependencies (staying at project root) run

```
$ bundle install
```

### How To

**See available tasks**

```
$ rake --tasks

rake report:build      # Generate report
rake report:clear      # Clear reports folder
rake report:run        # Start report server
rake test:normal       # Sequential tests execution
rake test:parallel[n]  # Parallel tests execution
```

**Execute tests**

To run tests in parallel please execute

```
$ rake test:parallel[n]
```

or (if you're ZSH user)

```
$ rake test:parallel\[n\]
```

where `n` - number of threads you want to use.


To run tests sequentially

```
$ rake test:normal     # or just rake as it's default
```

Running any of these commands will clear `reports` directory and populate it with new test results.

Currently, `config/config.yml` will tell framework to run tests using Chrome browser in headless mode.
To enable GUI mode just change `headless` param to `false`.

Also it is possible to run tests in Firefox. To do so just change `browser` config param to 'firefox'.

NOTE: In this framework headless mode currently supported only for Chrome.

**Run reports**

After tests finished execution (staying at project root) run:

```
$ rake report:build      # will generate index.html file based on reports<n>.json
$ rake report:run        # will run reports server

Running reports server on http://localhost:8025
[2018-01-23 05:09:20] INFO  WEBrick 1.4.2
[2018-01-23 05:09:20] INFO  ruby 2.5.0 (2017-12-25) [x86_64-darwin16]
[2018-01-23 05:09:20] INFO  WEBrick::HTTPServer#start: pid=22063 port=8025
```

By default reports server run on port 8025. It can be changed in `.env` file.
Having reports server running you can open report in browser at [http://localhost:8025](http://localhost:8025).

### Framework description

**Gems used**

All gems used in this project can be found in [Gemfile](https://github.com/thespecial/onliner/blob/master/Gemfile):

- [Cucumber](https://github.com/cucumber/cucumber) - BDD tool
- [Dotenv](https://github.com/bkeepers/dotenv) - to manage environment variables
- [page-object](https://github.com/cheezy/page-object) - to create page objects
- [parallel_tests](https://github.com/grosser/parallel_tests) - to run tests in parallel
- [Rake](https://github.com/ruby/rake) - to specify tasks
- [ReportBuilder](https://github.com/rajatthareja/ReportBuilder) - to generate test reports
- [RSpec Expectations](https://github.com/rspec/rspec-expectations) - to express expectations better
- [RuboCop](https://github.com/bbatsov/rubocop) - to keep Ruby code standarts
- [selenium-webdriver](https://github.com/SeleniumHQ/selenium/tree/master/rb) - to automate browser
- [Watir-Nokogiri](http://www.rubydoc.info/gems/watir-nokogiri/1.0.0) - work with HTML on the webpage

**Files structure**

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
  - `search_add_product_to_cart.feature` - cucumber feature file to describe feature and scenarios

**reports** - `report<n>.json` and `index.html` report files are placed here

