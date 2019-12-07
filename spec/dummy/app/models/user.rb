class User < ActiveRecord::Base
  devise :database_authenticatable, #:registerable,
    :recoverable, :rememberable, :trackable, #, :validatable
    :lockable, lock_strategy: :none, unlock_strategy: :none

  include EnjuLibrary::EnjuUser
  include EnjuBookmark::EnjuUser
end

Item.include(EnjuLibrary::EnjuItem)
Manifestation.include(EnjuBookmark::EnjuManifestation)
