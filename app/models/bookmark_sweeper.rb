class BookmarkSweeper < ActionController::Caching::Sweeper
  include ExpireEditableFragment
  observe Bookmark, Tag

  def after_save(record)
    case
    when record.is_a?(Bookmark)
      expire_editable_fragment(record.manifestation, ['show_list', 'detail'])
      expire_tag_cloud(record)
    when record.is_a?(Tag)
      record.taggings.collect(&:taggable).each do |taggable|
        expire_editable_fragment(taggable)
      end
    end
  end

  def after_destroy(record)
    after_save(record)
  end
end
