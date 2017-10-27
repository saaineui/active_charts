Feature: Generating assets
  In order to generate default/canon styling and hover/click events
  I want active_chart to create stylesheet and script files from templates

  Scenario: Installation
    When I run `active_charts install`
    Then the following files should exist:
      | app/assets/javascripts/active_charts.js |
      | app/assets/stylesheets/active_charts.css.scss |
