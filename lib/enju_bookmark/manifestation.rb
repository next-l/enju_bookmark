module EnjuBookmark
  module BookmarkManifestation
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_bookmark_manifestation
        include InstanceMethods
      end
    end

    module InstanceMethods
      def owned_tags_by_solr
        has_many :bookmarks, :include => :tags, :dependent => :destroy, :foreign_key => :manifestation_id
        has_many :users, :through => :bookmarks

        searchable do
          string :tag, :multiple => true do
            tags.collect(&:name)
          end
          text :tag do
            tags.collect(&:name)
          end
        end
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
