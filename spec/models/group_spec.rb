require 'rails_helper'

RSpec.describe Group, type: :model do
  before :all do
    User.destroy_all
    @user = User.new(name: 'Kasuki', email: 'first@email.com', password: '123456',
                     password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save!
  end

  before :each do
    Group.destroy_all
    @group = Group.create(name: 'Campero', total_amount: 10.0, author_id: @user.id)
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'is valid with valid attributes' do
    expect(@group).to be_valid
  end

  it 'is not valid without a name' do
    @group.name = nil
    expect(@group).to_not be_valid
  end

  it 'is not valid without a total_amount' do
    @group.total_amount = nil
    expect(@group).to_not be_valid
  end

  it 'is not valid without an author_id' do
    @group.author_id = nil
    expect(@group).to_not be_valid
  end

  it 'is not valid with a name longer than 50 characters' do
    @group.name = 'a' * 51
    expect(@group).to_not be_valid
  end

  it 'is not valid with a total_amount less than 0' do
    @group.total_amount = -1
    expect(@group).to_not be_valid
  end

  it 'is not valid with a total_amount greater than 999999999.99' do
    @group.total_amount = 10_000_000_000.0
    expect(@group).to_not be_valid
  end

  it 'is not valid with a total_amount with more than 2 decimals' do
    @group.total_amount = 10.123
    expect(@group).to_not be_valid
  end

  it "total amount for campero's group should be 10.00" do
    expect(@group.total_amount).to eq(10.0)
  end
end
