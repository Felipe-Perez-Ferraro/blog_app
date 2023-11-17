require 'rails_helper'

RSpec.feature 'Post Index Page', type: :feature do
  before do
    @user = User.create(name: 'Mia', photo: 'url1', bio: 'Bio 1')
    @post = Post.create(author: @user, title: 'Post 1', text: 'Text 1')
    @user.comments.create(user: @user, post: @post, text: 'Com 1')
    @user.likes.create(user: @user, post: @post)
    visit user_posts_path(@user)
  end

  scenario 'I can see user details' do
    expect(page).to have_css('img[src*="url1"]') # Image
    expect(page).to have_content('Mia') # Name
    expect(page).to have_content('Number of posts: 1') # Posts num
    expect(page).to have_content('Post 1') # Post title
    expect(page).to have_content('Text 1') # Post body
    expect(page).to have_content('Comments: 1') # Post comments
    expect(page).to have_content('Com 1') # Post comment
    expect(page).to have_content('Likes: 1') # Post likes
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view.' do
    @user.posts.create(author: @user, title: 'Post 2', text: 'Text 2')
    @user.posts.create(author: @user, title: 'Post 3', text: 'Text 3')
    @user.posts.create(author: @user, title: 'Post 4', text: 'Text 4')
    @user.posts.create(author: @user, title: 'Post 5', text: 'Text 5')

    visit user_posts_path(@user)
    click_link '2'
    expect(current_url).to include(user_posts_path(@user, page: '2'))
  end

  scenario "When I click on a post, it redirects me to that post's show page." do
    find("#post_id_#{@post.id}").click
    expect(current_path).to eq(user_post_path(@user, @post))
  end
end
