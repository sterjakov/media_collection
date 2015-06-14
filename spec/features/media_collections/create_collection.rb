require 'rails_helper'

feature 'Create collection', :media_collection do


  # Пользователь входит, создает приватную медиа коллекцию и выходит
  # Заходит другой пользователь и не может посмотреть эту коллекцию
  scenario 'user can login and create collection with one link and one image' do

    # Пользователь входит
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)

    # Пользователь создает приватную медиа коллекцию
    collection_name = "Тестовая коллекция"
    user_create_collection(collection_name, 0)
    created_media_collection = MediaCollection.find_by_name(collection_name)

    # Пользователь выходит
    click_link 'Выйти'

    # Другой пользователь входит
    user = FactoryGirl.create(:user_1)
    signin(user.email, user.password)

    # И не может просмотреть эту коллекцию
    expect{ visit media_collection_path(created_media_collection.id) }.to raise_error(CanCan::AccessDenied)

  end



  # Пользователь входит, создает открытую медиа коллекцию и выходит
  # Заходит другой пользователь и может посмотреть эту коллекцию
  scenario 'user can login and create collection with one link and one image' do

    # Пользователь входит
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)

    # Пользователь создает открытую медиа коллекцию
    collection_name = "Тестовая коллекция"
    user_create_collection(collection_name, 1)
    created_media_collection = MediaCollection.find_by_name(collection_name)

    # Пользователь выходит
    click_link 'Выйти'

    # Другой пользователь входит
    user = FactoryGirl.create(:user_1)
    signin(user.email, user.password)

    # И может просмотреть эту коллекцию
    visit media_collection_path(created_media_collection.id)
    expect(page).to have_content(collection_name)

  end


  # Пользователь создает коллекцию из 1-ой ссылки и 1-ой картинки
  # Значения для available:
  # 0 коллекция доступная только автору
  # 1 коллекция доступная кому угодно
  def user_create_collection name, available

    # Пользователь создает коллекцию
    visit new_media_collection_path
    fill_in :media_collection_name, with: name
    select(MediaCollection::AVAILABLE[available][0], :from => :media_collection_available)

    # Добавляем фото
    fill_in :media_collection_images_attributes_0_name, with: 'Тестовая фотография'
    page.attach_file(:media_collection_images_attributes_0_image, Rails.root + 'spec/fixtures/images/test.jpg')

    # Добавляем ссылку
    fill_in :media_collection_urls_attributes_0_name, with: 'Тестовая ссылка'
    fill_in :media_collection_urls_attributes_0_url, with: 'http://test.url'

    click_button 'Сохранить коллекцию!'
    expect(page).to have_content('Медиа коллекция успешно создана.')

  end


end
