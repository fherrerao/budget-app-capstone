require 'rails_helper'

RSpec.describe Entity, type: :model do
  before :all do
    User.destroy_all
    Group.destroy_all

    @user = User.new(name: 'Kasuki', email: 'first@email.com', password: '123456',
                     password_confirmation: '123456')    
    @user.save!

    @group = Group.create(name: 'Campero', total_amount: 10.0, author_id: @user.id)
    @group.save!
  end

  before :each do
    Entity.destroy_all
    @entity = Entity.create(name: 'Chicken', amount: 10.0, author_id: @user.id)
  end

  it 'is valid with valid attributes' do
    expect(@entity).to be_valid
  end

  it 'is not valid without a name' do
    @entity.name = nil
    expect(@entity).to_not be_valid
  end

  it 'is not valid without an amount' do
    @entity.amount = nil
    expect(@entity).to_not be_valid
  end

  it 'is not valid with amount less than 0' do
    @entity.amount = -1
    expect(@entity).to_not be_valid
  end

  it 'is not valid without an author' do
    @entity.author_id = nil
    expect(@entity).to_not be_valid
  end

  it 'the amount for Chicken transaction should be 10.00 ' do
    expect(@entity.amount).to eq(10.0)
  end
end
