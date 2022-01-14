require 'rails_helper'

RSpec.describe "Admin::V1::Users as :admin", type: :request do
  let!(:login_user) { create(:user) }

  context "GET /users" do
    let(:url) { "/admin/v1/users" }
    let!(:users) { create_list(:user, 5) }

    it "Returns all Users" do
      get url, headers: auth_header(login_user)
      expect(body_json['users']).to include *users.as_json(
        only: [:id, :name, :email, :profile])
    end

    it "Returns success status" do
      get url, headers: auth_header(login_user)
      expect(response).to have_http_status(:ok)
    end

  end

  context "POST /users" do
    let(:url) { "/admin/v1/users" }

    context "with valid params" do
      let(:user_params) { { user: attributes_for(:user) }.to_json }

      it "Add a new user" do
        expect do
          post url, headers: auth_header(login_user), params: user_params
        end.to change(User, :count).by(1)
      end

      it "Returns last added User" do
        post url, headers: auth_header(login_user), params: user_params
        expect_user = User.last.as_json(
          only: [:id, :name, :email, :profile])
        expect(body_json['user']).to eq expect_user
      end

      it "Returns success status" do
        post url, headers: auth_header(login_user), params: user_params
        expect(response).to have_http_status(:ok)
      end

    end

    context "with invalid params" do
      let(:user_invalid_params) do
        { user: attributes_for(:user, name: nil) }.to_json
      end

      it "Does not add a new User" do
        expect do
          post url, headers: auth_header(login_user), params: user_invalid_params
        end.to_not change(User, :count)
      end

      it "Returns error messages" do
        post url, headers: auth_header(login_user), params: user_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it "Returns unprocessable_entity status" do
        post url, headers: auth_header(login_user), params: user_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  context "PATCH /users/:id" do
    let(:user) { create(:user) }
    let(:url) { "/admin/v1/users/#{user.id}" }

    context "with valid params" do
      let(:new_name) { 'My New Name' }
      let(:user_params) { { user: { name: new_name } }.to_json }

      it "Updates User" do
        patch url, headers: auth_header(login_user), params: user_params
        user.reload
        expect(user.name).to eq new_name
      end

      it "Returns updated User" do
        patch url, headers: auth_header(login_user), params: user_params
        user.reload
        expect_user = user.as_json(only: [:id, :name, :email, :profile])
        expect(body_json['user']).to eq expect_user
      end

      it "Returns success status" do
        patch url, headers: auth_header(login_user), params: user_params
        expect(response).to have_http_status(:ok)
      end

    end

    context "with invalid params" do
      let(:user_invalid_params) do
        { user: attributes_for(:user, name: nil) }.to_json
      end

      it "Does not update User" do
        old_name = user.name
        patch url, headers: auth_header(login_user), params: user_invalid_params
        expect(user.name).to eq old_name
      end

      it "Returns error messages" do
        patch url, headers: auth_header(login_user), params: user_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it "Returns unprocessable_entity status" do
        patch url, headers: auth_header(login_user), params: user_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  context "DELETE /users/:id" do
    let!(:user) { create(:user) }
    let(:url) { "/admin/v1/users/#{user.id}" }

    it "Removes User" do
      expect do
        delete url, headers: auth_header(login_user)
      end.to change(User, :count).by(-1)
    end

    it "Does not return any body content" do
      delete url, headers: auth_header(login_user)
      expect(body_json).to_not be_present
    end

    it "Returns success status" do
      delete url, headers: auth_header(login_user)
      expect(response).to have_http_status(:no_content)
    end
  end

end