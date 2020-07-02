require "application_system_test_case"

class ClipsTest < ApplicationSystemTestCase
  setup do
    @clip = clips(:one)
  end

  test "visiting the index" do
    visit clips_url
    assert_selector "h1", text: "Clips"
  end

  test "creating a Clip" do
    visit clips_url
    click_on "New Clip"

    fill_in "Duration", with: @clip.duration
    fill_in "Filename", with: @clip.filename
    fill_in "Machine", with: @clip.machine_id
    fill_in "Name", with: @clip.name
    fill_in "Number", with: @clip.number
    fill_in "Slot", with: @clip.slot
    fill_in "Timecode", with: @clip.timecode
    click_on "Create Clip"

    assert_text "Clip was successfully created"
    click_on "Back"
  end

  test "updating a Clip" do
    visit clips_url
    click_on "Edit", match: :first

    fill_in "Duration", with: @clip.duration
    fill_in "Filename", with: @clip.filename
    fill_in "Machine", with: @clip.machine_id
    fill_in "Name", with: @clip.name
    fill_in "Number", with: @clip.number
    fill_in "Slot", with: @clip.slot
    fill_in "Timecode", with: @clip.timecode
    click_on "Update Clip"

    assert_text "Clip was successfully updated"
    click_on "Back"
  end

  test "destroying a Clip" do
    visit clips_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Clip was successfully destroyed"
  end
end
