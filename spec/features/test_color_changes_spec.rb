require 'rails_helper'


feature "Test Color Changes", type: :feature, js: true do
  scenario "User clicks color button" do
    visit('/')
    click_button("Colors!")
    expect(page).to have_content 'clicked!' #dump side effect to test for, but for now...
  end
end
