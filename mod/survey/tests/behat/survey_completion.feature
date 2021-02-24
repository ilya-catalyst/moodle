@mod @mod_survey @core_completion
Feature: A teacher can use activity completion to track a student progress
  In order to use activity completion
  As a teacher
  I need to set survey activities and enable activity completion

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
      | student1 | Student | 1 | student1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category | enablecompletion |
      | Course 1 | C1 | 0 | 1 |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
      | student1 | C1 | student |
    And I log in as "teacher1"

  Scenario: Require survey view
    Given the following "activities" exist:
      | activity   | name                   | intro                         | course | idnumber    |
      | survey     | Test survey name       | Test survey description       | C1     | survey1     |
    And I am on "Course 1" course homepage
    And I follow "Test survey name"
    And I navigate to "Edit settings" in current page administration
    And I set the following fields to these values:
      | Survey type | Critical incidents |
      | Completion tracking | Show activity as complete when conditions are met |
      | id_completionview   | 1 |
      | id_completionsubmit | 0 |
    And I press "Save and return to course"
    And I log out
    When I log in as "student1"
    And I am on "Course 1" course homepage
    And the "Test survey name" "survey" activity with "auto" completion should be marked as not complete
    And I follow "Test survey name"
    And I am on "Course 1" course homepage
    Then the "Test survey name" "survey" activity with "auto" completion should be marked as complete

  Scenario: Require survey submission
    Given the following "activities" exist:
      | activity   | name                   | intro                         | course | idnumber    |
      | survey     | Test survey name       | Test survey description       | C1     | survey1     |
    And I am on "Course 1" course homepage
    And I follow "Test survey name"
    And I navigate to "Edit settings" in current page administration
    And I set the following fields to these values:
      | Survey type | Critical incidents |
      | Completion tracking | Show activity as complete when conditions are met |
      | id_completionsubmit | 1 |
    And I press "Save and return to course"
    And I log out
    When I log in as "student1"
    And I am on "Course 1" course homepage
    And the "Test survey name" "survey" activity with "auto" completion should be marked as not complete
    And I follow "Test survey name"
    And I press "Click here to continue"
    And I am on "Course 1" course homepage
    Then the "Test survey name" "survey" activity with "auto" completion should be marked as complete
