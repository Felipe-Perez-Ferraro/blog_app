require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  it 'Should be valid' do
    expect(user).to be_valid
  end

  it 'Should not be valid (name example)' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'Should not be valid (photo example)' do
    user.photo = nil
    expect(user).to_not be_valid
  end

  it 'Should have 0 posts' do
    expect(user.post_counter).to eq(0)
  end

  it 'Should bring the 3 first posts' do
    first_post = Post.create(author: user, title: 'post 1', text: 'This is my first post')
    second_post = Post.create(author: user, title: 'post 2', text: 'This is my second post')
    third_post = Post.create(author: user, title: 'post 3', text: 'This is my third post')
    fourth_post = Post.create(author: user, title: 'post 4', text: 'This is my fourth post')

    expect(user.post_counter).to eq(4)
    expect(user.order_user_posts).to eq([fourth_post, third_post, second_post])
  end
end
