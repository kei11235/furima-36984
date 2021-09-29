require 'rails_helper'

def visit_with_http_auth(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit_with_http_auth(root_path)
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      fill_in 'user[last_name]', with: @user.last_name
      fill_in 'user[first_name]', with: @user.first_name
      fill_in 'user[last_name_kana]', with: @user.last_name_kana
      fill_in 'user[first_name_kana]', with: @user.first_name_kana
      select '2000', from: 'user[date(1i)]'
      select '1', from: 'user[date(2i)]'
      select '1', from: 'user[date(3i)]'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect do
        click_on('会員登録')
      end.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
      # ログアウトボタンやニックネームが表示されることを確認する
      expect(page).to have_content('ログアウト')
      expect(page).to have_content(@user.nickname)
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit_with_http_auth(root_path)
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''
      fill_in 'user[last_name]', with: ''
      fill_in 'user[first_name]', with: ''
      fill_in 'user[last_name_kana]', with: ''
      fill_in 'user[first_name_kana]', with: ''
      select '--', from: 'user[date(1i)]'
      select '--', from: 'user[date(2i)]'
      select '--', from: 'user[date(3i)]'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect do
        click_on('会員登録')
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ユーザーログイン機能', type: :system do
  context 'ログインに成功するとき' do
    it 'ログインに成功し、トップページに遷移する' do
      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      # トップページに移動する
      visit_with_http_auth(root_path)
      # トップページにサインインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # サインインページへ移動する
      visit new_user_session_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq new_user_session_path
      # すでに保存されているユーザーのemailとpasswordを入力する
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      # ログインボタンをクリックする
      click_on('ログイン')
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
    end
  end

  context 'ログインに失敗するとき' do
    it 'ログインに失敗し、再びサインインページに戻ってくる' do
      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      # トップページに遷移する
      visit_with_http_auth(root_path)
      # トップページにサインインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # サインインページへ移動する
      visit new_user_session_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq new_user_session_path
      # 誤ったユーザー情報を入力する
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      # ログインボタンをクリックする
      click_on('ログイン')
      # サインインページに戻ってきていることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'ユーザーログアウト機能' do
  it 'ログアウトを押すとログアウトできる' do
    # サインインする
    @user = FactoryBot.create(:user)
    sign_in(@user)
    # 「ログアウト」ボタンを押す
    click_on('ログアウト')
    # トップページに移動したことを確認する
    expect(current_path).to eq root_path
    # トップページに「新規作成」「ログイン」ボタンが表示されることを確認する
    expect(page).to have_content('ログイン')
    expect(page).to have_content('新規登録')
  end
end
