module EnjuBookmark
  module BookmarkUser
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_bookmark_user_model
        include InstanceMethods
        has_many :bookmarks, :dependent => :destroy
        acts_as_tagger

        attr_accessible :share_bookmarks
      end
    end

    module InstanceMethods
      def owned_tags_by_solr
        bookmark_ids = bookmarks.collect(&:id)
        if bookmark_ids.empty?
          []
        else
          Tag.bookmarked(bookmark_ids)
        end
      end
    end
  end
end
