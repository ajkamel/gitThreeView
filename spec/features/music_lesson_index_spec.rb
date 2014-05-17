require 'spec_helper'

feature "A Music Lessons Page shows Lessons" do



  background do

    MusicLesson.create!({
            points: 100,
            level: 1,
            global_level: 1,
            img: "http://placesheen.com/200/300",
            lesson_text: "This is a C Major Scale. Listen to the notes and watch as they light up on the keyboard.  Then play them back using your computer.",
            question_text:"The notes in a C Major Scale are: C,D,E,F,G,A,B,C.",
            solution_key_pattern: "11,22,33",
            category: "Scales",
            title: "C Major Scale"
            })

    visit("/")
    click_link("Sign up")
    fill_in("Email", with: 'john@doe.com')
    fill_in("Name", with: 'John Doe')
    fill_in("Username", with: 'jdoe')
    fill_in("Password", with: 'johndoe123')
    fill_in("Password confirmation", with: 'johndoe123')
    click_button("Sign up")
  end



  scenario "should display the titles and categories of the lessons" do
    lesson = MusicLesson.find_by(title: 'C Major Scale')
    expect(page).to have_content(lesson.category)
    expect(page).to have_content(lesson.title)
  end

  scenario "Clicking on a music lesson link should take you to the appropriate lesson" do
    lesson = MusicLesson.find_by(title: 'C Major Scale')
    click_link("Lesson #{lesson.level}: #{lesson.title}")
    expect(page).to have_content(lesson.title)
  end

end
