require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = '' # emailの値を空にする
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意であること' do
      existing_user = FactoryBot.create(:user, email: 'test@example.com') # 既存のユーザーを作成
      @user.email = 'test@example.com' # 同じメールアドレスを使った新しいユーザー
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは@を含む必要があること' do
      @user.email = 'invalid-email'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは6文字以上での入力が必須であること 5文字' do
      @user.password = '12345' # 5文字のパスワード
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードは半角英数字混合での入力が必須であること' do
      @user.password = 'password123' # 半角英数字混合
      @user.password_confirmation =  'password123'
      @user.valid?
      # binding.pry
      expect(@user).to be_valid
    end

    it 'パスワードが半角英字のみの場合は無効であること' do
      @user.password = 'password' # 半角英字のみ
      @user.password_confirmation = 'password'
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    end
    it 'パスワードが半角数字のみの場合は無効であること' do
      @user.password = '123456' # 半角数字のみ
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    end
    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      @user.password = 'password123'
      @user.password_confirmation = 'password456' # パスワードと異なる確認用パスワード
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'お名前(全角)姓が空では登録できない' do
      @user.last_name = ''
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'お名前(全角)名が空では登録できない' do
      @user.first_name = ''
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'お名前(全角)姓が半角での入力はできない' do
      @user.last_name = 'ﾊﾝｶｸ'
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end
    it 'お名前(全角)カナ姓が空では登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'お名前(全角)カナ名が空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it '生年月日が空では登録できない' do
      @user.birthday = ''
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
