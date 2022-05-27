require 'rails_helper'

RSpec.describe 'New Entity', type: :system do
  before(:all) do
    User.destroy_all
    Group.destroy_all
    Entity.destroy_all
    EntityGroups.destroy_all

    @user = User.new(name: 'Kasuki', email: 'first@email.com', password: '123456', password_confirmation: '123456')
    @user.save!

    @group = Group.new(name: 'Campero', total_amount: 122, author_id: @user.id)
    @group.save!

    @entity = Entity.new(name: 'Coca Cola', amount: 12, author_id: @user.id)
    @entity.save!

    @entity_groups = EntityGroups.new(group_id: @group.id, entity_id: @entity.id)
    @entity_groups.save!
  end

  describe 'create new entity' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: 'first@email.com'
      fill_in 'Password', with: '123456'
      click_button 'Next'
      visit new_group_entity_path(@group)
    end

    it 'should display the new entity page' do
      expect(page).to have_current_path(new_group_entity_path(@group))
    end

    it 'should have a form to create a new entity' do
      expect(page).to have_selector('form')
    end

    it 'should have a name field' do
      expect(page).to have_field('Name')
    end

    it 'should have a amount field' do
      expect(page).to have_field('Amount')
    end

    it 'should have a button to create a new transaction' do
      expect(page).to have_button('NEW TRANSACTION')
    end

    it 'is not possible to create a new entity without a name' do
      fill_in 'Amount', with: '12'
      click_button 'NEW TRANSACTION'
      expect(page).to have_content('Name can\'t be blank')
    end

    it 'is not possible to create a new entity without a amount' do
      fill_in 'Name', with: 'Coca Cola'
      click_button 'NEW TRANSACTION'
      expect(page).to have_content('Amount is not a number')
    end

    it 'is possible to create a new entity' do
      fill_in 'Name', with: 'Coca Cola'
      fill_in 'Amount', with: '12'
      click_button 'NEW TRANSACTION'
      expect(page).to have_content('Coca Cola')
    end
  end
end
