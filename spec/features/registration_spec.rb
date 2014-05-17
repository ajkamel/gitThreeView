require 'spec_helper'

feature 'A user can sign up and change information' do

  background do
    visit("/")
    click_link("Sign up")
    fill_in("Email", with: 'john@doe.com')
    fill_in("Name", with: 'John Doe')
    fill_in("Username", with: 'jdoe')
    fill_in("Password", with: 'johndoe123')
  end

  scenario "should sign up given valid information" do
    fill_in("Password confirmation", with: 'johndoe123')
    click_button("Sign up")
    expect(page).to have_content("jdoe")
  end

  scenario "should not be able to sign up with invalid information" do
    fill_in("Password confirmation", with: 'johndoe12')
    click_button("Sign up")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  # Click update button is clicking cancel account button

  # scenario "should be able to edit information with valid information" do
  #   fill_in("Password confirmation", with: 'johndoe123')
  #   click_button("Sign up")
  #   click_link("Edit Info")
  #   fill_in("Name", with: 'Johnny Doe')
  #   fill_in("Current password", with: 'johndoe123')
  #   click_button('Update')
  #   expect(page).to have_content("jdoe")
  # end

  # scenario "should be not able to edit information with invalid information" do
  #   fill_in("Password confirmation", with: 'johndoe123')
  #   click_button("Sign up")
  #   click_link("Edit Info")
  #   fill_in("Name", with: '')
  #   fill_in("Current password", with: 'johndoe123')
  #   click_button("Update")
  #   expect(page).to have_content("Name can't be blank")
  # end

end
