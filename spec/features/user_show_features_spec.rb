require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  before do
    @user = User.create(name: 'User 1', photo: 'url1', bio: 'Bio 1')
    @post1 = Post.create(id: 1, author: @user, title: 'post1', text: 'post1')
    @post2 = Post.create(id: 2, author: @user, title: 'post2', text: 'post2')
    @post3 = Post.create(id: 3, author: @user, title: 'post3', text: 'post3')
    @post4 = Post.create(id: 4, author: @user, title: 'post4', text: 'post4')
    visit user_path(@user)
  end

  scenario 'I can see user details' do
    expect(page).to have_css("img[src*='#{@user.photo}']")
    expect(page).to have_content('User 1')
    expect(page).to have_content('Number of posts: 4')
    expect(page).to have_content('Bio 1')
  end

  scenario 'I can see the user\'s first 3 posts' do
    expect(page).to have_content('post4')
    expect(page).to have_content('post3')
    expect(page).to have_content('post2')
  end

  scenario 'I can see a button that lets me view all of a user\'s posts' do
    expect(page).to have_link('See all posts', href: user_posts_path(@user))
  end

  scenario 'When I click a user\'s post, it redirects me to that post\'s show page' do
    visit user_path(@user)
    find('#post_id_4').click
    expect(current_path).to eq(user_post_path(@user, @post4))
  end

  scenario 'When I click to see all posts, it redirects me to the user\'s post index page' do
    expect(page).to have_link('See all posts', href: user_posts_path(@user))
  end
end
