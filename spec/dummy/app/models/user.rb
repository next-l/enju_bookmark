class User < ActiveRecord::Base
  devise :database_authenticatable, #:registerable,
    :recoverable, :rememberable, :trackable, #, :validatable
    :lockable, lock_strategy: :none, unlock_strategy: :none

  include EnjuSeed::EnjuUser
  include EnjuBookmark::EnjuUser
end

Item.include(EnjuLibrary::EnjuItem)
Item.include(EnjuCirculation::EnjuItem)
Manifestation.include(EnjuBookmark::EnjuManifestation)
Manifestation.include(EnjuCirculation::EnjuManifestation)
