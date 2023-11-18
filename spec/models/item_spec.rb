require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
  @item = FactoryBot.build(:item)
  end
 
  describe '商品登録' do
    context '商品登録できるとき' do
    
      it '全ての入力が存在するれば登録できる' do
        @item.valid?
        expect(@item).to be_valid
      end
      it '有効なカテゴリーが表示されていること' do
        valid_categories = ['---', 'レディース', 'メンズ', 'ベビー・キッズ', 'インテリア・住まい・小物', '本・音楽・ゲーム', 'おもちゃ・ホビー・グッズ', '家電・スマホ・カメラ', 'スポーツ・レジャー', 'ハンドメイド', 'その他']
        expect(Category.all.map(&:name)).to eq(valid_categories)
      end
      it '有効なカテゴリーが表示されていること' do
        valid_categories = ['---', 'レディース', 'メンズ', 'ベビー・キッズ', 'インテリア・住まい・小物', '本・音楽・ゲーム', 'おもちゃ・ホビー・グッズ', '家電・スマホ・カメラ', 'スポーツ・レジャー', 'ハンドメイド', 'その他']
        expect(Category.all.map(&:name)).to eq(valid_categories)
      end
      it '有効な商品の状態が表示されていること' do
        valid_product_statuses = ['---', '新品・未使用', '未使用に近い', '目立った傷や汚れあり', 'やや傷や汚れあり', '傷や汚れあり', '全体的に状態が悪い']
        expect(ProductStatus.all.map(&:name).sort).to eq(valid_product_statuses.sort)
      end
      it '有効な配送料の負担が表示されていること' do
        valid_shipping_cost_burdens = ['---', '着払い（購入者負担）', '送料込み（出品者負担）']
        expect(ShippingCostBurden.all.map(&:name).sort).to eq(valid_shipping_cost_burdens.sort)
      end
      it '有効な発送元の地域が表示されていること' do
        valid_origin_regions = ['---', '北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県', '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', '神奈川県', '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県', '静岡県', '愛知県', '三重県', '滋賀県', '京都府', '大阪府', '兵庫県', '奈良県', '和歌山県', '鳥取県', '島根県', '岡山県', '広島県', '山口県', '徳島県', '香川県', '愛媛県', '高知県', '福岡県', '佐賀県', '長崎県', '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県']
        expect(OriginRegion.all.map(&:name).sort).to eq(valid_origin_regions.sort)
      end
      it '有効な発送までの日数が表示されていること' do
        valid_delivery_times = ['---', '１〜２日で発送', '２〜３日で発送', '４〜７日で発送']
        expect(DeliveryTime.all.map(&:name).sort).to eq(valid_delivery_times.sort)
      end

      it '価格が¥300から¥9,999,999の範囲内で保存可能であること' do
        @item.price = 300
        expect(@item).to be_valid

        @item.price = 9_999_999
        expect(@item).to be_valid
      end


    end  
  end

  context '商品登録できないとき' do

    it '画像が添付されていない場合は登録できない' do
      @item.image = nil  
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が空では登録できない' do
      @item.product_name = nil 
      @item.valid?
      expect(@item.errors.full_messages).to include("Product name can't be blank")
    end
    it '商品の説明が空では登録できない' do
      @item.description = nil 
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it 'カテゴリーが空では登録できない' do
      @item.category_id = nil 
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it 'カテゴリーが選択肢以外の値だと登録できない' do
      @item.category_id = 'invalid_category'
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it '商品の状態が空では登録できない' do
      @item.product_status_id = nil 
      @item.valid?
      expect(@item.errors.full_messages).to include("Product status can't be blank")
    end
    it '配送料の負担が空では登録できない' do
      @item.shipping_cost_burden_id = nil 
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping cost burden can't be blank")
    end
    it '発送元地域が空では登録できない' do
      @item.origin_region_id = nil 
      @item.valid?
      expect(@item.errors.full_messages).to include("Origin region can't be blank")
    end
    it '発送日までの日数が空では登録できない' do
      @item.delivery_time_id = nil 
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery time can't be blank")
    end
    it '価格が空では登録できない' do
      @item.price = nil 
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it '価格が半角数字以外では登録できない。全角では登録できない' do
      @item.price = '５００'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end
    it '価格が半角数字以外では登録できない。英字では登録できない' do
      @item.price = 'abc'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end
    it '価格が¥300未満では保存できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
    it '価格が¥10,000,000以上では保存できないこと' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end
    it 'userが紐づいていない場合は登録できない' do
      @item.user = nil
      @item.valid?
      #binding.pry
      expect(@item.errors.full_messages).to include("User must exist")
    end


  end
end
