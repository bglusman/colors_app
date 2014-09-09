require 'rails_helper'

feature "Test Color Changes", type: :feature, js: true do

  before do
    stub_const("PersistentQueue::DEFAULT_NAME", 'feature_test_queue')
  end

  scenario "User clicks color button" do
    visit('/')
    click_button("Colors!")
    expect(page).to have_content 'Coming right up!'
  end

  scenario "triggering bgColorChange event changes color" do
    visit('/')
    page.execute_script("$(document).trigger('changeBgColor', [{red:5, blue: 5, green: 5}])")
    page.find('html')['style'].should == 'background-color: rgb(5, 5, 5);'
  end

  scenario "polls backend on click" do
    visit('/')
    expect_any_instance_of(ColorsController).to receive(:create)
    click_button("Colors!")
  end

end
