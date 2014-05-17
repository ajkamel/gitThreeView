require 'spec_helper'

describe User do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should have_and_belong_to_many (:code_lessons) }
  it { should have_and_belong_to_many (:music_lessons) }

  subject(:user) { User.create(name: 'John Doe',
                               email: 'john@doe.com',
                               username: 'jdoe',
                               avatar: 'test.png',
                               password: 'johndoe123',
                               password_confirmation: 'johndoe123')}
  describe ".new" do
    it "should create user with name, username, email" do
      expect(user.name).to eq('John Doe')
      expect(user.email).to eq('john@doe.com')
      expect(user.username).to eq('jdoe')
    end
  end

end
