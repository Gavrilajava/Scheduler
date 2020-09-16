require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:each) do
    @valid_params = {
      name: "John Doe", 
      email: "john.doe@gmail.com",
      role: "Admin",
      password: "VerySecurePassword123!",
      password_confirmation: "VerySecurePassword123!"
    }
    @user = User.create(@valid_params)
  end
  describe 'GET new' do
    it 'renders the new action successfully' do
      :new
      expect(response).to have_http_status :success
    end
  end
  describe 'POST create' do
    describe 'with valid params' do
      before do
        post :create, params: {login: {name: "John Doe", password: "VerySecurePassword123!"}}
      end
      it 'sets sucess message' do
        expect(flash[:success]).to_not eq nil
      end
      it 'redirects to root page' do
        expect(response).to redirect_to root_path
      end
    end
    describe 'with invalid params' do
      before do
        post :create, params: {login: {name: "John Doe", password: "WrongPassword"}}
      end
      it 'sets errors' do
        expect(flash[:alert]).to_not eq nil
      end
      it 'redirects to login page' do
        expect(response).to redirect_to login_path
      end
    end
  end
  describe 'DELETE destroy' do
    before do
      post :create, params: {login: {name: "John Doe", password: "VerySecurePassword123!"}}
      delete :destroy, params: {id: @user.id}
    end
    it 'destroys the session user' do
      expect(session[:user_id]).to eq nil
    end
    it 'sets sucess message' do
      expect(flash[:success]).to_not eq nil
    end
    it 'redirects to login page' do
      expect(response).to redirect_to login_path
    end
  end
  after(:each) do
    User.destroy_all
  end
end
