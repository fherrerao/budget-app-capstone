require 'rails_helper'

RSpec.describe 'Group Index', type: :system do
  before(:all) do
    User.destroy_all

    @user = User.new(name: 'Kasuki', email: 'first@email.com', password: '123456', password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save!

    @group = Group.new(name: 'Campero', total_amount: 122, author_id: @user.id)
    @group.save!
  end

  describe 'log in' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: 'first@email.com'
      fill_in 'Password', with: '123456'
      click_button 'LOG IN'
    end

    it 'should display Categories' do
      expect(page).to have_content('Categories')
    end

    it 'should display the group index page' do
      expect(page).to have_content('Campero')
    end

    it 'should display the total amount of the category' do
      expect(page).to have_content('$122.0')
    end

    it 'should have a button to add a new category' do
      expect(page).to have_link('NEW CATEGORY')
    end

    it 'should redirect to the new category page' do
      click_link('NEW CATEGORY')
      expect(page).to have_current_path(new_group_path)
    end
  end
end
