require 'rails_helper'

RSpec.describe Post, type: :model do
  let (:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  let (:post) { Post.new(author: user, title: 'A title', text: 'This is my first post') }

  it 'Should be valid' do
    expect(post).to be_valid
  end

  it 'Should not be valid (empty title)' do
    post.title = ''
    expect(post).to_not be_valid
  end

  it 'Should not be valid (long title)' do
    post.title = 'A' * 251
    expect(post).to_not be_valid
  end

  it 'Should have 0 comments' do
    expect(post.comments_counter).to eq(0)
  end

  it 'Should have 0 likes' do
    expect(post.likes_counter).to eq(0)
  end

  it 'Should bring the 5 first comments' do
    first_com = Comment.create(post: post, user: user, text: 'Hi Tom!')
    second_com = Comment.create(post: post, user: user, text: 'Hi Tom!')
    third_com = Comment.create(post: post, user: user, text: 'Hi Tom!')
    fourth_com = Comment.create(post: post, user: user, text: 'Hi Tom!')
    fifth_com = Comment.create(post: post, user: user, text: 'Hi Tom!')
    sixth_com = Comment.create(post: post, user: user, text: 'Hi Tom!')

    expect(post.comments_counter).to eq(6)
    expect(post.order_post_comments).to eq([sixth_com, fifth_com, fourth_com, third_com, second_com])
  end

  it 'Should have 1 like in the post' do 
    like = Like.create(post: post, user: user)
    expect(post.likes_counter).to eq(1)
  end
end
