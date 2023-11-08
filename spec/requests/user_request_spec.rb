require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:each) do
    @user = User.create(name: 'User', photo: 'photoLink', bio: 'Bio')
  end

  describe 'GET /index' do
    it 'should return http success' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it "should render the 'users/index' template" do
      get users_path
      expect(response).to render_template('users/index')
    end

    it 'Should get the <h1> tag content' do
      get users_path
      assert_select '.users_title', 'users:'
    end
  end

  describe 'GET /show' do
    it 'should return http success' do
      get user_path(@user)
      expect(response).to have_http_status(200)
    end

    it "should render the 'users/show' template" do
      get user_path(@user)
      expect(response).to render_template('users/show')
    end

    it 'Should get the <h1> tag content' do
      get user_path(@user)
      assert_select '.user_title', 'user:'
    end
  end
end
