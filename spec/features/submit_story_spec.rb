require 'rails_helper'

RSpec.feature "Submit story" do
  describe "Guest user" do
    it "should not be able to access new_story_path" do
      visit new_story_path

      # Make sure it is redirected to home page
      expect(page).to have_current_path root_path
    end
  end

  describe "Authenticated user" do
    before do
      user = create :user
      # Stub available at support/authentication_helper.rb
      stub_login_as user

      # Create dummy tag
      @tag1 = create :tag
      @tag2 = create :tag
    end

    scenario "Submit valid story (title, url, tags)" do
      # Click the link
      click_link "Submit"

      # Fill in the form
      story_title = "Test new story"
      fill_in "story[title]", with: story_title
      fill_in "story[url]", with: "https://test.com/story"
      select @tag1.description, from:  "story[tag_names][]"
      select @tag2.description, from:  "story[tag_names][]"

      # Then submit
      click_button "Submit Story"

      # Expectation it will redirected to comments path
      story = Story.find_by(title: story_title)
      expect(page).to have_current_path story.comments_path
      expect(page).to have_content story.title
      expect(page).to have_content @tag1.tag
      expect(page).to have_content @tag2.tag
    end

    scenario "Submit valid story (title, text, tags)" do
      # Click the link
      click_link "Submit"

      # Fill in the form
      story_title = "Test new story"
      fill_in "story[title]", with: story_title
      fill_in "story[description]", with: "My description"
      select @tag1.description, from:  "story[tag_names][]"
      select @tag2.description, from:  "story[tag_names][]"

      # Then submit
      click_button "Submit Story"

      # Expectation it will redirected to comments path
      story = Story.find_by(title: story_title)
      expect(page).to have_current_path story.comments_path
      expect(page).to have_content story.title
      expect(page).to have_content @tag1.tag
      expect(page).to have_content @tag2.tag
    end

    scenario "Submit valid story (title, url, text, tags)" do
      # Click the link
      click_link "Submit"

      # Fill in the form
      story_title = "Test new story"
      fill_in "story[title]", with: story_title
      fill_in "story[url]", with: "https://0xblockchain.network/test"
      fill_in "story[description]", with: "My description"
      select @tag1.description, from:  "story[tag_names][]"
      select @tag2.description, from:  "story[tag_names][]"

      # Then submit
      click_button "Submit Story"

      # Expectation it will redirected to comments path
      story = Story.find_by(title: story_title)
      expect(page).to have_current_path story.comments_path
      expect(page).to have_content story.title
      expect(page).to have_content @tag1.tag
      expect(page).to have_content @tag2.tag
    end

    scenario "Submit invalid story (missing title, url, text, tags)" do
      # Click the link
      click_link "Submit"

      # Don't fill in the form, Then submit
      click_button "Submit Story"

      # Expectation it will redirected to comments path
      expect(page).to have_current_path stories_path
      expect(page).to have_content "Oops"
      expect(page).to have_content "Title is too short (minimum is 3 characters)"
      expect(page).to have_content "Description must contain text if no URL posted"
      expect(page).to have_content "Must have at least one non-media (PDF, video) tag. If no tags apply to your content, it probably doesn't belong here."
    end

    scenario "Submit invalid story (missing url, text, tags)" do
      # Click the link
      click_link "Submit"

      # Fill in the form
      story_title = "Test new story"
      fill_in "story[title]", with: story_title
      # Then submit
      click_button "Submit Story"

      # Expectation it will redirected to stories path
      # and display an error
      expect(page).to have_current_path stories_path
      expect(page).to have_content "Oops"
      expect(page).to have_content "Description must contain text if no URL posted"
      expect(page).to have_content "Must have at least one non-media (PDF, video) tag. If no tags apply to your content, it probably doesn't belong here."
    end

    scenario "Submit invalid story (missing tags)" do
      # Click the link
      click_link "Submit"

      # Fill in the form
      story_title = "Test new story"
      fill_in "story[title]", with: story_title
      fill_in "story[description]", with: "My description"

      # Then submit
      click_button "Submit Story"

      # Expectation it will redirected to stories path
      # and display an error
      expect(page).to have_current_path stories_path
      expect(page).to have_content "Oops"
      expect(page).to have_content "Must have at least one non-media (PDF, video) tag. If no tags apply to your content, it probably doesn't belong here."
    end

    scenario "Submit already posted story" do
      # First create dummy story using FactoryBot
      story = create :story

      # Click the link
      click_link "Submit"

      # Fill in the form
      story_title = "Test new story"
      fill_in "story[title]", with: story_title
      # Submit the same url
      fill_in "story[url]", with: story.url
      select @tag1.description, from: "story[tag_names][]"
      select @tag2.description, from: "story[tag_names][]"

      # Then submit
      click_button "Submit Story"

      # Expectation it will redirected to stories path
      # and display an error
      expect(page).to have_current_path stories_path
      expect(page).to have_content "Oops"
      expect(page).to have_content "This story was already submitted"
    end
  end
end
