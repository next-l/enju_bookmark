class Ability
  include CanCan::Ability

  def initialize(user)
    case user.try(:role).try(:name)
    when 'Administrator'
      can :manage, [
        Bookmark,
        BookmarkStat,
        BookmarkStatHasManifestation,
        Tag
      ]
    when 'Librarian'
      can [:read, :create, :update], BookmarkStat
      can :read, BookmarkStatHasManifestation
      can :manage, [
        Bookmark,
        Tag
      ]
    when 'User'
      can [:index, :create], Bookmark
      can :show, Bookmark do |bookmark|
        if bookmark.user == user
          true
        elsif user.share_bookmarks
          true
        else
          false
        end
      end
      can [:update, :destroy], Bookmark do |bookmark|
        bookmark.user == user
      end
      can :read, BookmarkStat
      can :read, Tag
    else
      can :read, BookmarkStat
      can :read, Tag
    end
  end
end
