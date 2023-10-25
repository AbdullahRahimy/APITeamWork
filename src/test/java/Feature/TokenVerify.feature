Feature: US3 and US4
  Background: Test ReUsing Codes
    Given url "https://qa.insurance-api.tekschool-students.com"
    * def tokenResult = callonce read('GenToken.feature')
    * def token = "Bearer " + tokenResult.response.token

  Scenario: Send valid username invalid token to /api/token/verify
    And path "/api/token/verify"
    And param username = "supervisor"
    And param token = token
    When method get
    Then print response
    And status 200

  Scenario: Send invalid username valid token to /api/token/verify
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/token/verify"
    And param username = "wrongusername"
    And param token = token
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"