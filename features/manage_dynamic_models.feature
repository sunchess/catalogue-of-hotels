Feature: Manage dynamic_models
  In order to make a model
  As an admin
  I want to create and manage models


  Background:
  Given I am an admin

  Scenario: Register new dynamic_model
    And I am on the new dynamic_model page
    When I fill in "dynamic_model_title" with "Place"
    And I press "dynamic_model_submit"
    Then I should see "Place"

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for 
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
  Scenario: Delete dynamic_model
    Given the following dynamic_models:
      |title|
      |Place|
      |User|
    When I delete the 2rd dynamic_model
    Then I should be on the dynamic models page
    And I should see "Place"
    And I should see "Place"
