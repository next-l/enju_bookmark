FactoryBot.define do
  factory :bookmark do |f|
    f.sequence(:title){|n| "bookmark_#{n}"}
    f.sequence(:url){|n| "http://example.jp/#{n}"}
    f.user_id{FactoryBot.create(:user).id}
  end
end
