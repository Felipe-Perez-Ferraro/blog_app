require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before(:each) do
    @user = User.create(name: "User", photo: "photoLink", bio: "Bio") 
    @post = Post.create(author_id: @user.id, title: "Post title", text: "Post text") 
  end

  describe "GET /index" do
    it "should return http success" do 
      get user_posts_path(@user)
      expect(response).to have_http_status(200)
    end

    it "should render the 'posts/index' template" do 
      get user_posts_path(@user)
      expect(response).to render_template('posts/index')
    end

    it "Should get the <h1> tag content" do 
      get user_posts_path(@user)
      assert_select '.posts_title', 'posts:'
    end
  end

  describe "GET /show" do
    it "should return http success" do 
      get user_post_path(user_id: @user.id, id: @post.id)
      expect(response).to have_http_status(200)
    end

    it "should render the 'posts/show' template" do 
      get user_post_path(user_id: @user.id, id: @post.id)
      expect(response).to render_template('posts/show')
    end

    it "Should get the <h1> tag content" do 
      get user_post_path(user_id: @user.id, id: @post.id)
      assert_select '.post_title', 'post:'
    end
  end
end
