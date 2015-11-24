# -*- encoding: utf-8 -*-
class User < ActiveRecord::Base
  devise :database_authenticatable, #:registerable,
    :recoverable, :rememberable, :trackable, #, :validatable
    :lockable, :lock_strategy => :none, :unlock_strategy => :none

  include EnjuLeaf::EnjuUser
  include EnjuBookmark::EnjuUser
end
