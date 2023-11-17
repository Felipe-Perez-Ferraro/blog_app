require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  before do
    @user = User.create(name: 'Mia', photo: 'url1', bio: 'Bio 1')
    @post = Post.create(author: @user, title: 'Post 1', text: 'Text 1')
    @user.comments.create(user: @user, post: @post, text: 'Com 1 - by Mia')
    @user.comments.create(user: @user, post: @post, text: 'Com 2 - by Mia')
    @user.likes.create(user: @user2, post: @post)
    visit user_post_path(@user, @post)
  end

  scenario 'I can see user details' do
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Mia')
    expect(page).to have_content('Comments: 2')
    expect(page).to have_content('Likes: 1')
  end

  scenario 'I can see the post body.' do
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Text 1')
  end

  scenario 'I can see the username of each commentor.' do
    expect(page).to have_content('@Mia:')
  end

  scenario 'I can see the comment each commentor left.' do
    expect(page).to have_content('Com 1 - by Mia')
    expect(page).to have_content('Com 2 - by Mia')
  end
end
