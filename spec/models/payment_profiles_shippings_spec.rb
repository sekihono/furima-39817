require 'rails_helper'

RSpec.describe PaymentProfilesShippings, type: :model do
  before do
  #before(:each) do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @payment_profiles_shippings = FactoryBot.build(:payment_profiles_shippings, item_id: item.id, user_id: user.id)
  end


  describe '配送先住所登録' do
    context '配送先住所登録できるとき' do
    
      it '全ての入力が存在するれば登録できる' do
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings).to be_valid
      end

      it '建物名が空でも登録できること' do
        @payment_profiles_shippings.building_name = nil
        expect(@payment_profiles_shippings).to be_valid
      end
    end
  
    context '配送先住所が登録できないとき' do

      it '郵便番号が添付されていない場合は登録できない' do
        @payment_profiles_shippings.postal_code = nil  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が数字のみ（3桁ハイフン4桁出ない）場合は登録できない' do
        @payment_profiles_shippings.postal_code = '1234567'  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it '都道府県が空の場合は登録できない' do
        @payment_profiles_shippings.origin_region_id = nil  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Origin region can't be blank")
      end

      it '都道府県が{1:---}の場合は登録できない' do
        @payment_profiles_shippings.origin_region_id = '1'  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Origin region can't be blank")
      end

      it '市区町村が空の場合は登録できない' do
        @payment_profiles_shippings.city = nil  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空の場合は登録できない' do
        @payment_profiles_shippings.street_number = nil  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Street number can't be blank")
      end

      it '電話番号が空の場合は登録できない' do
        @payment_profiles_shippings.phone_number = nil  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では登録できない' do
        @payment_profiles_shippings.phone_number = '12345678' 
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が12桁以上では登録できない' do
        @payment_profiles_shippings.phone_number = '123456789012'
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号は半角数字以外が含まれている場合は購入できない' do
        @payment_profiles_shippings.phone_number = '090-1234567'  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Phone number is not a number")
      end

      it 'tokenが空の場合は登録できない' do
        @payment_profiles_shippings.token = nil  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @payment_profiles_shippings.user_id = nil  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @payment_profiles_shippings.item_id = nil  
        @payment_profiles_shippings.valid?
        expect(@payment_profiles_shippings.errors.full_messages).to include("Item can't be blank")
      end



      
    end

  end
end
