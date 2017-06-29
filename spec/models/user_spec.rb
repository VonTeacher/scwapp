require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe 'user model validations' do

    it 'should be valid with username and email' do
      expect(@user).to be_valid
    end

    it 'should not be valid without a username' do
      @user.username = ' '
      expect(@user).not_to be_valid
    end

    it 'should require a username at least 6 characters long' do
      @user.username = 'short'
      expect(@user).not_to be_valid
    end

    it 'should not be valid without an email address' do
      @user.email = ' '
      expect(@user).not_to be_valid
    end

    it 'should not be valid with an incorrect email address' do
      invalid_addresses = %w(foo@example,com foo_at_example.com foo@ex_ample.com foo@ex+ample.com foo@example.com.)
      invalid_addresses.each do |i|
        @user.email = i
        expect(@user).not_to be_valid
      end
    end

    it 'should require unique email addresses' do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).not_to be_valid
    end

    it 'should save email addresses as lowercase' do
      mixed_case_email = 'TesT@eXaMPLe.CoM'
      @user.email = mixed_case_email
      @user.save
      @user.reload
      expect(mixed_case_email.downcase).to eq(@user.email)
    end

    it 'should require a non-blank password' do
      @user.password = @user.password_confirmation = ' ' * 6
      expect(@user).not_to be_valid
    end

    it 'should require a minimum length on password' do
      @user.password = @user.password_confirmation = 'tests'
      expect(@user).not_to be_valid
    end

  end

  it 'authenticated? should return false for a user with a nil digest' do
    expect(@user.authenticated?('')).to eq false
  end

end
