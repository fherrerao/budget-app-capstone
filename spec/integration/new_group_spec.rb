require 'rails_helper'

RSpec.describe 'New Group', type: :system do
  before(:all) do
    User.destroy_all
    Group.destroy_all

    @user = User.new(name: 'Kasuki', email: 'first@email.com', password: '123456', password_confirmation: '123456')
    @user.save!
  end

  describe 'create new category' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: 'first@email.com'
      fill_in 'Password', with: '123456'
      click_button 'Next'
      click_link 'NEW CATEGORY'
    end

    it 'should display the new category page' do
      expect(page).to have_current_path(new_group_path)
    end

    it 'should have a form to create a new category' do
      expect(page).to have_selector('form')
    end

    it 'should have a name field' do
      expect(page).to have_field('Name')
    end

    it 'should have a button to create a new category' do
      expect(page).to have_button('NEW CATEGORY')
    end

    it 'is not possible to create a new category without a name' do
      fill_in 'Name', with: ''
      click_button 'NEW CATEGORY'
      expect(page).to have_content('Name can\'t be blank')
    end
  end
end
