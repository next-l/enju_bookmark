require "enju_bookmark/engine"
require "enju_bookmark/user"
require "enju_bookmark/bookmark_url"
require "enju_bookmark/calculate_stat"
require "enju_bookmark/expire_tag_cloud"
require "enju_bookmark/suggest_tag"
require "enju_bookmark/bookmark_helper"

module EnjuBookmark
end

ActiveRecord::Base.send :include, EnjuBookmark::BookmarkUser
