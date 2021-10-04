require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep(0.1)
  end

  describe '商品購入機能' do
    context '商品が購入できる場合' do
      it 'postal_code, area_id, municipalities, address, phone_num, tokenが存在すれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'bulidingは空でも登録できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end
    context '商品が購入できないとき' do
      it 'postal_codeは空では購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeは半角数字でないと購入できない' do
        @order_address.postal_code = '１２３-４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code は「-（ハイフン）」を用いた半角数字で正しく登録してください')
      end
      it 'postal_codeは「-」が「○○○-○○○○」の形でないと購入できない' do
        @order_address.postal_code = '1-234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code は「-（ハイフン）」を用いた半角数字で正しく登録してください')
      end
      it 'area_idの値が1（ユーザーが選択していない状態）では出品できない' do
        @order_address.area_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Area は選択項目が足りません')
      end
      it 'municipalitiesが空では購入できない' do
        @order_address.municipalities = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipalities can't be blank")
      end
      it 'addressが空では購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numが空では購入できない' do
        @order_address.phone_num = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num can't be blank")
      end
      it 'phone_numは0から始まる半角数字でなければ購入できない' do
        @order_address.phone_num = '1234567891'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone num は半角数字で電話番号を入力してください')
      end
      it 'phone_numは半角数字でなければ購入できない' do
        @order_address.phone_num = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone num は半角数字で電話番号を入力してください')
      end
      it 'phone_numが9桁以下では購入できない' do
        @order_address.phone_num = '012345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone num は半角数字で電話番号を入力してください')
      end
      it 'phone_numが12桁以上では購入できない' do
        @order_address.phone_num = '012345678912'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone num は半角数字で電話番号を入力してください')
      end
      it 'tokenが空では登録できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いてないと購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いてないと購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
