@assets
Feature: Insert an image into a page
  As a cms author
  I want to insert an image into a page
  So that I can insert them into my content efficiently

  Background:
    Given a "page" "About Us"
    And a "image" "assets/folder1/file1.jpg"
    And a "image" "assets/folder1/file2.jpg"
    And I am logged in with "ADMIN" permissions
    And I go to "/admin/pages"
    And I click on "About Us" in the tree

  Scenario: I can insert an image from a URL
    Given I press the "Insert Media" button
    Then I should see "Choose files to upload..."

    When I press the "From the web" button
    And I fill in "RemoteURL" with "http://www.silverstripe.com/themes/sscom/images/silverstripe_logo_web.png"
    And I press the "Add url" button
    Then I should see "silverstripe_logo_web.png (www.silverstripe.com)" in the ".ss-assetuploadfield span.name" element

    When I press the "Insert" button  
    Then the "Content" HTML field should contain "silverstripe_logo_web.png"
    # Required to avoid "unsaved changed" browser dialog
    Then I press the "Save draft" button

  @assets
  Scenario: I can insert an image uploaded from my own computer
    Given I press the "Insert Media" button
    And I press the "From your computer" button
    And I attach the file "testfile.jpg" to "AssetUploadField" with HTML5
    # TODO Delay previous step until upload succeeded
    And I wait for 2 seconds
    Then there should be a file "assets/Uploads/testfile.jpg"
    When I press the "Insert" button
    Then the "Content" HTML field should contain "testfile.jpg"
    # Required to avoid "unsaved changed" browser dialog
    Then I press the "Save draft" button

  @assets
  Scenario: I can overwrite an existing image with one uploaded from my own computer
    Given a "image" "assets/Uploads/file1.jpg"
    When I press the "Insert Media" button
    And I press the "From your computer" button
    And I attach the file "file1.jpg" to "AssetUploadField" with HTML5
    # TODO Delay previous step until upload succeeded
    And I wait for 2 seconds
    Then I should see "Overwrite"
    When I press the "Overwrite" button
    Then there should be a file "assets/Uploads/file1.jpg"
    When I press the "Insert" button
    Then the "Content" HTML field should contain "file1.jpg"
    # Required to avoid "unsaved changed" browser dialog
    Then I press the "Save draft" button

  @todo 
  Scenario: I can insert an image from the CMS file store
    Given I press the "Insert Media" button
    And I press the "From the CMS" button
    And I select "folder1" in the "Find in Folder" dropdown
    And I select "file1.jpg"
    When I press the "Insert" button
    Then the "Content" HTML field should contain "file1.jpg"
    # Required to avoid "unsaved changed" browser dialog
    Then I press the "Save draft" button

  @todo
  Scenario: I can insert multiple images at once
    Given I press the "Insert Media" button
    And I press the "From the CMS" button
    And I select "folder1" in the "Find in Folder" dropdown
    And I select "file1.jpg"
    And I select "file2.jpg"
    When I press the "Insert" button
    Then the "Content" HTML field should contain "file1.jpg"
    And the "Content" HTML field should contain "file2.jpg"
    # Required to avoid "unsaved changed" browser dialog
    Then I press the "Save draft" button

  @todo
  Scenario: I can edit properties of an image before inserting it
    Given I press the "Insert Media" button
    And I press the "From the CMS" button
    And I select "folder1" in the "Find in Folder" dropdown
    And I select "file1.jpg"
    And I follow "Edit"
    When I fill in "Alternative text (alt)" with "My alt"
    And I press the "Insert" button
    Then the "Content" HTML field should contain "file1.jpg"
    And the "Content" HTML field should contain "My alt"
    # Required to avoid "unsaved changed" browser dialog
    Then I press the "Save draft" button

  @todo
  Scenario: I can edit dimensions of an image before inserting it
    Given I press the "Insert Media" button
    And I press the "From the CMS" button
    And I select "folder1" in the "Find in Folder" dropdown
    And I select "file1.jpg"
    And I follow "Edit"
    When I fill in "Width" with "10"
    When I fill in "Height" with "20"
    And I press the "Insert" button
    Then the "Content" HTML field should contain "<img src=assets/folder1/file1.jpg width=10 height=20>"
    # Required to avoid "unsaved changed" browser dialog
    Then I press the "Save draft" button

  @todo
  Scenario: I can edit dimensions of an existing image
    Given the "page" "About us" contains "<img src=assets/folder1/file1.jpg>"
    And I reload the current page
    When I highlight "<img src=assets/folder1/file1.jpg>" in the "Content" HTML field
    And I press the "Insert Media" button
    Then I should see "file1.jpg"
    When I fill in "Width" with "10"
    When I fill in "Height" with "20"
    And I press the "Insert" button
    Then the "Content" HTML field should contain "<img src=assets/folder1/file1.jpg width=10 height=20>"
    # Required to avoid "unsaved changed" browser dialog
    Then I press the "Save draft" button