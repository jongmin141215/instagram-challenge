require 'rails_helper'

feature 'commenting' do
  before do
    user = create :user
    sign_in(user)
    user.pictures.create({picture_file_name: 'associations.jpg'})
  end

  context 'creating a comment' do
    scenario 'users can add a comment to a picture' do
      visit '/pictures'
      click_link 'Create comment'
      fill_in 'Content', with: 'Great'
      click_button 'Comment'
      expect(page).to have_content 'Great'
      expect(current_path).to eq '/pictures'
    end

    scenario 'users cannot post empty comment' do
      visit '/pictures'
      click_link 'Create comment'
      fill_in 'Content', with: ''
      click_button 'Comment'
      expect(page).not_to have_link 'Delete this comment'
      expect(page).to have_content 'You cannot post an empty comment'
    end
  end

  context 'deleting a comment' do
    before do
      visit '/pictures'
      click_link 'Create comment'
      fill_in 'Content', with: 'Great'
      click_button 'Comment'
    end
    scenario 'users can delete a comment' do
      visit '/pictures'
      click_link 'Delete this comment'
      expect(page).not_to have_content 'Great'
    end
  end
end
