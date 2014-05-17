require 'spec_helper'

feature "A user can navigate from the welcome page" do

  background do
    User.create(email: "john@doe.com",
                           name: 'John Doe',
                           username: "jdoe",
                           avatar: 'test.png',
                           password: "johndoe123",
                           password_confirmation: "johndoe123")
    visit("/")
  end

  scenario "should navigate to sign in page from home page" do
    click_link("Sign in")
    expect(page).to have_content("Sign in")
  end

  scenario "should navigate to create account page from home page" do
    click_link("Sign up")
    expect(page).to have_content("Sign up")
  end

  scenario "should view profile page from home page" do
    sign_in('john@doe.com', 'johndoe123')
    visit("/")
    click_link("Account")
    expect(page).to have_content("jdoe")
  end

  scenario "should not be able to sign in or up if logged in" do
    sign_in('john@doe.com', 'johndoe123')
    visit("/")
    click_link("Sign up")
    expect(page).to have_content("You are already signed in")
    visit("/")
    click_link("Sign in")
    expect(page).to have_content("You are already signed in")
  end
end
