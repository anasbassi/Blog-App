require 'rails_helper'
describe 'Posts-index', type: :feature do
  describe 'users/posts/index' do
    before(:each) do
      @user_one = User.create(name: 'John', photo: 'photo.svg', bio: 'lorem ipsum', posts_counter: 0)
      @user_two = User.create! name: 'Eric', photo: 'photo.svg', bio: 'lorem ipsum', posts_counter: 0

      @post1 = @user_one.posts.create(title: 'first post', text: 'description', comments_counter: 0, likes_counter: 0)
      @post2 = @user_one.posts.create(title: 'second post', text: 'description', comments_counter: 0, likes_counter: 0)
      @comment_one = @post1.comments.create(text: 'comment one', author_id: @user_one.id)
      @comment_two = @post1.comments.create(text: 'comment two', author_id: @user_two.id)

      @like = @post1.likes.create!(author_id: @user_one.id)
      visit user_posts_path(@user_one.id)
    end
    it 'Should set the link of the picture to the img src' do
      visit '/'
      all('img').each do |i|
        expect(i[:src]).to eq('photo.svg')
      end
    end
    scenario "I can see the user's username" do
      expect(page).to have_content('John')
    end
    scenario 'I can see the number of posts the user has written' do
      expect(page).to have_content('Number of posts:')
    end
    scenario "I can see a post's title." do
      expect(page).to have_content('first post')
    end
    scenario "I can see some of the post's body." do
      expect(page).to have_content('description')
    end
    scenario 'I can see the first comments on a post.' do
      expect(page).to have_content('comment one')
    end
    scenario 'I can see how many comments a post has.' do
      expect(page).to have_content('Comments')
    end
    scenario 'I can see how many likes a post has.' do
      expect(page).to have_content('Likes')
    end
    it 'can see a section for pagination if there are more posts than fit on the view.' do
      expect(page).to have_content 'next'
    end
    it "When I click on a post, it redirects me to that post's show page." do
      visit user_post_path(@user_one.id, @post1.id)
      expect(page).to have_current_path user_post_path(@user_one.id, @post1.id)
    end
  end
end
