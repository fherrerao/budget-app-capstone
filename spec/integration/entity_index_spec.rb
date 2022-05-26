require 'rails_helper'

RSpec.describe 'Entity Index', type: :system do
  before(:all) do
    User.destroy_all
    Group.destroy_all

    @user = User.new(name: 'Kasuki', email: 'first@email.com', password: '123456', password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save!

    @group = Group.new(name: 'Campero', total_amount: 122 , author_id: @user.id)
    @group.save!

    @entity = Entity.new(name: 'Coca Cola', amount: 12, author_id: @user.id)
    @entity.save!

    @entity_groups = EntityGroups.new(group_id: @group.id, entity_id: @entity.id)
    @entity_groups.save!
  end

  describe 'log in' do
    before:each do
      visit new_user_session_path
      fill_in 'Email', with: 'first@email.com'
      fill_in 'Password', with: '123456'
      click_button 'LOG IN'
      visit group_entities_path(@group)
    end

    it 'should display Transactions' do
      expect(page).to have_content('Transactions')
    end

    it 'should display Total category' do
      expect(page).to have_content('Total category')
    end

    it 'should have the entitities path' do
      expect(page).to have_current_path(group_entities_path(@group))
    end

    it 'should have the amount of the category' do
      expect(page).to have_content('$12.0')
    end
    
    it 'should have a button to add a new transaction' do
      expect(page).to have_link('New transaction')      
    end

    it 'should redirect to the new transaction page' do
      click_link('New transaction')
      expect(page).to have_current_path(new_group_entity_path(@group))
    end
  end
end
