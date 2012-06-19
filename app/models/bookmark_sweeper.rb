class BookmarkSweeper < ActionController::Caching::Sweeper
  include ExpireEditableFragment
  include ExpireTagCloud
  observe Bookmark, Tag

  def after_save(record)
    case record.class.to_s.to_sym
    when :Bookmark
      expire_editable_fragment(record.manifestation)
      expire_tag_cloud(record)
    when :Tag
      record.taggings.collect(&:taggable).each do |taggable|
        expire_editable_fragment(taggable)
      end
    end
  end

  def after_destroy(record)
    after_save(record)
  end
end
