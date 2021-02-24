@mod @mod_forum
Feature: Set a certain number of discussions as a completion condition for a forum
  In order to ensure students are participating on forums
  As a teacher
  I need to set a minimum number of discussions to mark the forum activity as completed

  Scenario: Set X number of discussions as a condition
    Given the following "users" exist:
      | username | firstname | lastname | email |
      | student1 | Student | 1 | student1@example.com |
      | teacher1 | Teacher | 1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1 | 0 |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
      | student1 | C1 | student |
    And the following "activity" exists:
      | activity | forum |
      | course   | C1    |
      | idnumber | 00001 |
      | name     | Test forum name |
      | description | Test forum name description |
      | section     | 1                           |
      | completion  | 2                           |
      | completionview | 0                        |
      | completiondiscussionsenabled | 1          |
      | completiondiscussions        | 2          |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on
    And I navigate to "Edit settings" in current page administration
    And I set the following fields to these values:
      | Enable completion tracking | Yes |
    And I press "Save and display"
    And I am on "Course 1" course homepage
    And I follow "Test forum name"
    And I navigate to "Edit settings" in current page administration
    And I set the following fields to these values:
      | completion  | 2                           |
      | completionview | 0                        |
      | completiondiscussionsenabled | 1          |
      | completiondiscussions        | 2          |
    And I press "Save and return to course"
    And I log out
    And I log in as "student1"
    And I am on "Course 1" course homepage
    Then the "Test forum name" "forum" activity with "auto" completion should be marked as not complete
    And I add a new discussion to "Test forum name" forum with:
      | Subject | Post 1 subject |
      | Message | Body 1 content |
    And I add a new discussion to "Test forum name" forum with:
      | Subject | Post 2 subject |
      | Message | Body 2 content |
    And I am on "Course 1" course homepage
    Then the "Test forum name" "forum" activity with "auto" completion should be marked as complete
    And I log out
    And I log in as "teacher1"
    And I am on "Course 1" course homepage
    And "Student 1" user has completed "Test forum name" activity
