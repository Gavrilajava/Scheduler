require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @admin = User.create(
      name: "admin", 
      email: "admin@gmail.com",
      role: "Admin",
      password: "VerySecurePassword123!",
      password_confirmation: "VerySecurePassword123!"
    )
    @valid_params = {
      name: "John Doe", 
      email: "john.doe@gmail.com",
      role: "User",
      password: "VerySecurePassword123!",
      password_confirmation: "VerySecurePassword123!"
    }
    session[:user_id] = @admin.id
  end
  describe 'GET index' do
    it 'renders the index action successfully' do
      :index
      expect(response).to have_http_status :success
    end
  end
  describe 'POST create' do
    describe 'with valid params' do
      before do
        post :create, params: {user: @valid_params}
      end
      it 'sets sucess message' do
        expect(flash[:success]).to_not eq nil
      end
      it 'redirects to users page' do
        expect(response).to redirect_to users_path
      end
    end
    describe 'with invalid params' do
      before do
        @valid_params[:password_confirmation] = "not a password"
        post :create, params: {user: @valid_params}
      end
      it 'sets errors' do
        expect(flash[:alert]).to_not eq nil
      end
      it 'redirects to users page' do
        expect(response).to redirect_to users_path
      end
    end
  end
  describe 'DELETE destroy' do
    before do
      user = User.create(@valid_params)
      delete :destroy, params: {id: user.id}
    end
    it 'destroys the user' do
      expect(User.find_by(name: @valid_params[:name])).to eq nil
    end
    it 'sets sucess message' do
      expect(flash[:success]).to_not eq nil
    end
    it 'redirects to users page' do
      expect(response).to redirect_to users_path
    end
  end
  after(:each) do
    User.destroy_all
  end
end
