require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  before do
    @user1 = User.create(name: 'Sergio', photo: 'url1', bio: 'Bio 1', post_counter: 3)
    @user2 = User.create(name: 'Felipe', photo: 'url2', bio: 'Bio 2', post_counter: 5)
  end

  scenario 'I can see the username of all other users' do
    visit users_path

    expect(page).to have_content('Sergio')
    expect(page).to have_content('Felipe')
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path

    expect(page).to have_css('img[src*="url1"]')
    expect(page).to have_css('img[src*="url2"]')
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path

    expect(page).to have_content('Number of posts: 3')
    expect(page).to have_content('Number of posts: 5')
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path

    click_link 'Sergio'

    expect(current_path).to eq(user_path(@user1))
    expect(page).to have_content('Number of posts: 3')
  end
end
