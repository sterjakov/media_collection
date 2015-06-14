# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do

  # Scenario: Visit the home page
  scenario 'visit the home page' do
    visit root_path
    expect(page).to have_content 'Общедоступные коллекции'
  end

end
