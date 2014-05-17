require 'spec_helper'

feature "A user can sign in" do

  background { User.create(email: "john@doe.com",
                           name: 'John Doe',
                           username: "jdoe",
                           avatar: 'test.png',
                           password: "johndoe123",
                           password_confirmation: "johndoe123") }

  scenario "should sign in the user given a valid email and password" do
    sign_in("john@doe.com", "johndoe123")
    expect(page).to have_content("jdoe")
  end

  scenario "should not sign in a user with an invalid email and password" do
    sign_in("john@doe.com", "invalid")
    expect(page).to have_content("Invalid email or password.")
  end
end
