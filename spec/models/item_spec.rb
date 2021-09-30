require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できる場合' do
      it 'image、name、explain、category_id、status_id、shopping_charge_id、area_id、days_id、priceが存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'explainが空では出品できない' do
        @item.explain = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explain can't be blank")
      end
      it 'category_idの値が1（ユーザーが選択していない状態）では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category は選択項目が足りません')
      end
      it 'status_idの値が1（ユーザーが選択していない状態）では出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status は選択項目が足りません')
      end
      it 'shopping_charge_idの値が1（ユーザーが選択していない状態）では出品できない' do
        @item.shopping_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shopping charge は選択項目が足りません')
      end
      it 'area_idの値が1（ユーザーが選択していない状態）では出品できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Area は選択項目が足りません')
      end
      it 'days_idの値が1（ユーザーが選択していない状態）では出品できない' do
        @item.days_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Days は選択項目が足りません')
      end
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが¥300~¥9,999,999の間以外では出品できない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は￥300~￥9,999,999の範囲で値段をつけてください')
        @item.price = 100000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は￥300~￥9,999,999の範囲で値段をつけてください')
      end
      it 'priceが半角数値でなければ出品できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字で入力してください')
      end
      it 'userが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
