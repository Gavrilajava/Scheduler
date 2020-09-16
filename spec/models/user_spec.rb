require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @valid_params = {
      name: "John Doe", 
      email: "john.doe@gmail.com",
      role: "Admin",
      password: "VerySecurePassword123!",
      password_confirmation: "VerySecurePassword123!"
    }
  end
  describe 'create and validate' do
    it "is valid with valid attributes" do
      expect(User.new(@valid_params)).to be_valid
    end
    it "is not valid without a name" do
      @valid_params.delete(:name)
      expect(User.new(@valid_params)).to_not be_valid
    end
    it "is not valid without a email" do
      @valid_params.delete(:email)
      expect(User.new(@valid_params)).to_not be_valid
    end
    it "is not valid without a role" do
      @valid_params.delete(:role)
      expect(User.new(@valid_params)).to_not be_valid
    end
    it "is not valid with incorrect role" do
      @valid_params[:role] = "Stranger"
      expect(User.new(@valid_params)).to_not be_valid
    end
    it "is not valid with non unique name" do
      user = User.create(@valid_params)
      expect(User.new(@valid_params)).to_not be_valid
    end
    it "is not valid if password don't match confirmation" do
      @valid_params[:password_confirmation] = "not_password"
      expect(User.new(@valid_params)).to_not be_valid
    end
    it "is not valid if password is weak" do
      @valid_params[:password] = "password"
      @valid_params[:password_confirmation] = "password"
      expect(User.new(@valid_params)).to_not be_valid
    end
    it "is valid if password is long" do
      @valid_params[:password] = "Jhebsacecneiadcasf1afnnnwee"
      @valid_params[:password_confirmation] = "Jhebsacecneiadcasf1afnnnwee"
      expect(User.new(@valid_params)).to be_valid
    end
    it "is not valid if password is long" do
      @valid_params[:password] = "124324621341241"
      @valid_params[:password_confirmation] = "124324621341241"
      expect(User.new(@valid_params)).to_not be_valid
    end
  end
  describe 'Last Admin' do
    it "shouldn't destroy the last admin" do
      user = User.create(@valid_params)
      user.destroy
      expect(User.count).to_not eq(0)
    end
    it "shouldn't update the last admin" do
      user = User.create(@valid_params)
      user.update(role: "User")
      expect(User.first.admin).to eq(true)
    end
    it "should change role if admin is not last" do
      user = User.create(@valid_params)
      user2 = User.create(name: "John Doe2", 
      email: "john.doe2@gmail.com",
      role: "Admin",
      password: "VerySecurePassword123!",
      password_confirmation: "VerySecurePassword123!")
      user.update(role: "User")
      expect(User.first.admin).to eq(false)
    end
  end
  describe '.admin' do
    it "return true if user is admin" do
      user = User.create(@valid_params)
      expect(user.admin).to be true 
    end
    it "return false if user is not admin" do
      @valid_params[:role] = "User"
      user = User.create(@valid_params)
      expect(user.admin).to be false 
    end
  end
  after(:each) do
    User.destroy_all
  end
end
