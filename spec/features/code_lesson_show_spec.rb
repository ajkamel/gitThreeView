require 'spec_helper'

feature 'Page should display the individual lesson that we can play'  do

  background do
    @lesson1 = CodeLesson.create(
                            title: "Code Lesson 1",
                            category: "Coding",
                            lesson_text: "This is a test okay",
                            question_text: "Will this test work?",
                            img: "http://placesheen.com/200/300 ",
                            level: 1,
                            global_level: 1,
                            points: 20,
                            start_row: 5,
                            start_col: 1,
                            solution_row: 1,
                            solution_col: 5)
    visit("/")
    click_link("Sign up")
    fill_in("Email", with: 'john@doe.com')
    fill_in("Name", with: 'John Doe')
    fill_in("Username", with: 'jdoe')
    fill_in("Password", with: 'johndoe123')
    fill_in("Password confirmation", with: 'johndoe123')
    click_button("Sign up")
    user = User.find_by(name: 'John Doe')
    user.code_lessons << @lesson1

  end

  scenario "when visiting the code lesson page it loads the game" do
    visit("/code_lessons/#{@lesson1.id}")
    expect(page).to have_content(@lesson1.title)
    expect(page).to have_content(@lesson1.points)
  end

  scenario "when visiting the code lesson page it loads the game" do
    visit("/code_lessons/#{@lesson1.id}")
    expect(page).to have_content(@lesson1.lesson_text)
  end

  # scenario "when visiting the code lesson page it loads the game" do

  # end

end
