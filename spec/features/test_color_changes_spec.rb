require 'rails_helper'

feature "Test Color Changes", type: :feature, js: true do

  before do
    stub_const("PersistentQueue::DEFAULT_NAME", 'feature_test_queue')
  end

  scenario "User clicks color button" do
    visit('/')
    click_button("Colors!")
    expect(page).to have_content 'Coming right up!' #test for side effect of click
  end
end
