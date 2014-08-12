module EnjuBookmark
  module BookmarkProfile
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_bookmark_profile_model
        attr_accessible :share_bookmarks, as: :admin
      end
    end
  end
end
