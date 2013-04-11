class EnjuBookmark::SetupGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def setup
    rake("enju_bookmark_engine:install:migrations")
    inject_into_file 'app/models/user.rb',
      "  enju_bookmark_user_model\n", :after => "enju_leaf_user_model\n"
    inject_into_class 'app/models/manifestation.rb', Manifestation,
      "  enju_bookmark_manifestation_model\n"
end
