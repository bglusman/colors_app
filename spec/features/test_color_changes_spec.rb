require 'rails_helper'


feature "Test Color Changes", type: :feature, js: true do
  scenario "User clicks color button" do
    visit('/')
    click_button("Colors!")
    expect(page).to have_content 'Coming right up!' #test for side effect of click
  end
end
