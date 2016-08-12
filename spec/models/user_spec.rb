require 'rails_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  fixtures :all

  describe ".export" do
    it "should export all user's information" do
      lines = User.export
      CSV.parse(lines, col_sep: "\t")
      expect(lines).not_to be_empty
      expect(lines.split(/\n/).size).to eq User.count + 1
    end

    it "should export share_bookmarks" do
      user = FactoryGirl.create(:user,
        profile: FactoryGirl.create(:profile,
          share_bookmarks: true))
      lines = User.export
      rows = CSV.new(lines, col_sep: "\t", headers: true)
      rows.each do |row|
        if row["username"] == user.username
          expect(row["share_bookmarks"]).to eq "true"
        end
      end
    end

    it "should work even if EnjuBookmark module is undefined" do
      Object.send(:remove_const, :EnjuBookmark)
      lines = User.export
      expect(lines).not_to be_empty
      expect(lines.split(/\n/).size).to eq User.count + 1
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                       :integer         not null, primary key
#  email                    :string(255)     default(""), not null
#  encrypted_password       :string(255)     default(""), not null
#  reset_password_token     :string(255)
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer         default(0)
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string(255)
#  last_sign_in_ip          :string(255)
#  password_salt            :string(255)
#  confirmation_token       :string(255)
#  confirmed_at             :datetime
#  confirmation_sent_at     :datetime
#  unconfirmed_email        :string(255)
#  failed_attempts          :integer         default(0)
#  unlock_token             :string(255)
#  locked_at                :datetime
#  authentication_token     :string(255)
#  created_at               :datetime        not null
#  updated_at               :datetime        not null
#  deleted_at               :datetime
#  username                 :string(255)     not null
#  library_id               :integer         default(1), not null
#  user_group_id            :integer         default(1), not null
#  expired_at               :datetime
#  required_role_id         :integer         default(1), not null
#  note                     :text
#  keyword_list             :text
#  user_number              :string(255)
#  state                    :string(255)
#  locale                   :string(255)
#  enju_access_key          :string(255)
#  save_checkout_history    :boolean         default(FALSE), not null
#  checkout_icalendar_token :string(255)
#  share_bookmarks          :boolean
#  save_search_history      :boolean         default(FALSE), not null
#  answer_feed_token        :string(255)
#

