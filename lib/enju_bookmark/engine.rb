require 'devise'
require 'cancan'
require 'acts-as-taggable-on'
require 'attribute_normalizer'
require 'sunspot_rails'
require 'state_machine'
require 'friendly_id'
require 'will_paginate'
require 'addressable/uri'
require 'nkf'
require 'acts_as_list'

module EnjuBookmark
  class Engine < ::Rails::Engine
  end
end
