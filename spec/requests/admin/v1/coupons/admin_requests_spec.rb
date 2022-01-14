require 'rails_helper'

RSpec.describe "Admin::V1::Coupons as :admin", type: :request do
  let(:user) { create(:user) }

  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupon, 5) }

    it "returns all Coupons" do
      get url, headers: auth_header(user)
      expect(body_json['coupons']).to contain_exactly *coupons.as_json(
        only: [:id, :code, :status, :discount_value, :due_date])
    end

    it "return success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end



  context "POST /coupons" do
    let(:url) { "/admin/v1/coupons" }

    context "with invalid params" do
      let(:coupons_params) { { coupon: attributes_for(:coupon) }.to_json }
    
      it "add a new Coupon" do
        expect do
          post url, headers: auth_header(user), params: coupons_params
        end.to change(Coupon, :count).by(1)
      end

      it "returns last added Coupon" do
        post url, headers: auth_header(user), params: coupons_params
        expect_coupon = Coupon.last.as_json(
          only: [:id, :code, :status, :discount_value, :due_date])
        expect(body_json['coupon']).to eq expect_coupon
      end

      it "returns success status" do
        post url, headers: auth_header(user), params: coupons_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:coupon_invalid_params) do
        { coupon: attributes_for(:coupon, code: nil) }.to_json
      end

      it "does not add a new Coupon" do
        expect do
          post url, headers: auth_header(user), params: coupon_invalid_params
        end.to_not change(Coupon, :count)
      end

      it "returns error messages" do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key('code')
      end
      
      it "returns unprocessable_entity status" do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

  end

  context "PATCH /coupons/:id" do
    let(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }

    context "with valid params" do
      let(:new_code) { 'My New Coupon Code' }
      let(:coupon_params) { { coupon: { code: new_code } }.to_json }
    
      it "Updates Coupon" do
        patch url, headers: auth_header(user), params: coupon_params
        coupon.reload
        expect(coupon.code).to eq new_code
      end

      it "Returns updated Coupon" do
        patch url, headers: auth_header(user), params: coupon_params
        coupon.reload
        expected_coupon = coupon.as_json(
          only: [:id, :code, :status, :discount_value, :due_date])
        expect(body_json['coupon']).to eq expected_coupon
      end

      it "Returns success status" do
        patch url, headers: auth_header(user), params: coupon_params
        expect(response).to have_http_status(:ok)
      end

    end

    context "with invalid params" do
      let(:coupon_invalid_params) do
        { coupon: attributes_for(:coupon, code: nil) }.to_json
      end

      it "Does not update Coupon" do
        old_code = coupon.code
        patch url, headers: auth_header(user), params: coupon_invalid_params
        coupon.reload
        expect(coupon.code).to eq old_code
      end

      it "Returns error messages" do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key('code')
      end

      it "Returns unprocessable_entity status" do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  context "DELETE /coupons/:id" do
    let!(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }

    it "Removes Coupon" do
      expect do
        delete url, headers: auth_header(user)
      end.to change(Coupon, :count).by(-1)
    end

    it "Does not return any body content" do
      delete url, headers: auth_header(user)
      expect(body_json).to_not be_present
    end

    it "Returns success status" do
      delete url, headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end

  end
end