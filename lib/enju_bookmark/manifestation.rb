module EnjuBookmark
  module BookmarkManifestation
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_bookmark_manifestation_model
        include InstanceMethods
        has_many :bookmarks, -> {includes(:tags)}, :dependent => :destroy, :foreign_key => :manifestation_id
        has_many :users, :through => :bookmarks

        settings do
          mappings dynamic: 'false', _routing: {required: false} do
            indexes :tag
          end
        end
      end
    end

    module InstanceMethods
      def as_indexed_json(options={})
        super.merge(
          tag: tags.collect(&:name)
        )
      end

      def bookmarked?(user)
        return true if user.bookmarks.where(:url => url).first
        false
      end

      def tags
        if self.bookmarks.first
          self.bookmarks.tag_counts
        else
          []
        end
      end
    end
  end
end
