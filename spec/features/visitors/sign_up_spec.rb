# Feature: Sign up
#   As a visitor
#   I want to sign up
#   So I can visit protected areas of the site
feature 'Sign Up', :devise do


  # Scenario: Visitor cannot sign up with invalid email address
  #   Given I am not signed in
  #   When I sign up with an invalid email address
  #   Then I see an invalid email message
  scenario 'visitor cannot sign up with invalid email address' do
    sign_up_with('bogus', 'please123', 'please123')
    expect(page).to have_content 'E-mail ' + I18n::t('errors.messages.invalid')
  end

  # Scenario: Visitor cannot sign up without password
  #   Given I am not signed in
  #   When I sign up without a password
  #   Then I see a missing password message
  scenario 'visitor cannot sign up without password' do
    sign_up_with('test@example.com', '', '')
    expect(page).to have_content I18n::t('activerecord.attributes.user.password') + ' ' + I18n::t('errors.messages.blank')
  end

  # Scenario: Visitor cannot sign up with a short password
  #   Given I am not signed in
  #   When I sign up with a short password
  #   Then I see a 'too short password' message
  scenario 'visitor cannot sign up with a short password' do
    sign_up_with('test@example.com', 'ple', 'ple')
    expect(page).to have_content I18n::t('activerecord.attributes.user.password') + ' ' + I18n::t('errors.messages.too_short.few', count: 4 )
  end

  # Scenario: Visitor cannot sign up without password confirmation
  #   Given I am not signed in
  #   When I sign up without a password confirmation
  #   Then I see a missing password confirmation message
  scenario 'visitor cannot sign up without password confirmation' do
    sign_up_with('test@example.com', 'please123', '')
    expect(page).to have_content "Повторный пароль не совпадает с подтверждением"
  end

  # Scenario: Visitor cannot sign up with mismatched password and confirmation
  #   Given I am not signed in
  #   When I sign up with a mismatched password confirmation
  #   Then I should see a mismatched password message
  scenario 'visitor cannot sign up with mismatched password and confirmation' do
    sign_up_with('test@example.com', 'please123', 'mismatch')
    expect(page).to have_content "Повторный пароль не совпадает с подтверждением"
  end

end
