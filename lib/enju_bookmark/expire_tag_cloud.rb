module ExpireTagCloud
  def expire_tag_cloud(bookmark)
    I18n.available_locales.each do |locale|
      Role.all_cache.each do |role|
        expire_fragment(controller: :tags, action: :index, page: 'user_tag_cloud', user_id: bookmark.user.username, locale: locale, role: role.name)
        expire_fragment(controller: :tags, action: :index, page: 'public_tag_cloud', locale: locale, role: role.name, user_id: nil)
      end
    end
  end
end
