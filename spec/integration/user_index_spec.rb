require 'rails_helper'

RSpec.describe 'USers', type: :feature do
  describe 'user#index' do
    before(:each) do
      User.create(name: 'John', photo: 'photo.svg', bio: 'lorem ipsum', posts_counter: 0)
      User.create(name: 'Eric', photo: 'photo.svg', bio: 'lorem ipsum', posts_counter: 0)
      visit root_path
      @user = User.first!
      visit '/'
    end
    scenario 'I can see the username of all other users.' do
      expect(page).to have_content('Eric')
      expect(page).to have_content('John')
    end
    it 'I can see the profile picture for each user.' do
      visit '/'
      all('img').each do |i|
        expect(i[:src]).to eq('photo.svg')
      end
    end
    scenario 'I can see the number of posts each user has written.' do
      expect(page).to have_content('Number of posts:')
    end
    it "Should navigate to user's show page" do
      visit user_path(@user.id)
      expect(current_path).to eq(user_path(@user.id))
    end
  end
end
