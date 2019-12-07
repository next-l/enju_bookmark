module EnjuBookmark
  module ProfilesController
    extend ActiveSupport::Concern

    def profile_update_params
      attrs = [
        :full_name, :full_name_transcription,
        :keyword_list, :locale,
        :save_checkout_history, :checkout_icalendar_token, # EnjuCirculation
        :save_search_history, # EnjuSearchLog
      ]
      attrs += [
        :share_bookmarks,
        :library_id, :expired_at, :birth_date,
        :user_group_id, :required_role_id, :note, :user_number, {
          user_attributes: [
            :id, :email, :current_password, :auto_generated_password, :locked,
            {user_has_role_attributes: [:id, :role_id]}
          ]
        }
      ] if current_user.has_role?('Librarian')
      params.require(:profile).permit(*attrs)
    end
  end
end
