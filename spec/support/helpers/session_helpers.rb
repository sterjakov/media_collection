module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in 'E-mail', with: email
      fill_in 'Пароль', with: password
      fill_in 'Повторите пароль', :with => confirmation
      click_button 'Зарегистрироваться'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'E-mail', with: email
      fill_in 'Пароль', with: password
      click_button 'Войти'
    end
  end
end
