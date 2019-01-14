module EnjuBookmark
  module EnjuProfile
    extend ActiveSupport::Concern

    included do
      attr_accessible :share_bookmarks, as: :admin
    end
  end
end
