require 'rails_helper'

RSpec.describe 'Login', type: :system do
  before(:all) do
    User.destroy_all

    @user = User.new(name: 'Kasuki', email: 'first@email.com', password: '123456', password_confirmation: '123456')    
    @user.save!
  end

  describe 'visit log in' do
    before :each do
      visit new_user_session_path
    end

    it 'should be able to login' do
      expect(page).to have_content('Sign up')
      expect(page).to have_content('Forgot your password?')      
    end

    it 'is valid with valid attributes' do
      fill_in 'Email', with: 'first@email.com'
      fill_in 'Password', with: '123456'
      click_button 'Next'
      expect(page).to have_content('Signed in successfully.')
    end

    it 'should fail if left the email' do
      fill_in 'Password', with: '123456'
      click_button 'Next'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'should fail if left the password' do
      fill_in 'Email', with: 'first@email.com'
      click_button 'Next'
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
