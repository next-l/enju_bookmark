require 'enju_biblio'
require 'acts-as-taggable-on'
require 'nkf'

module EnjuBookmark
  class Engine < ::Rails::Engine
    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( spinner.gif )
    end
  end
end
