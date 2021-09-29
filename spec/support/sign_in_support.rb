module SignInSupport

  def visit_with_http_auth(path)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end
  
  def sign_in(user)
    visit_with_http_auth(root_path)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on('ログイン')
    expect(current_path).to eq(root_path)
  end

end