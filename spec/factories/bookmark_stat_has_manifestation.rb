FactoryBot.define do
  factory :bookmark_stat_has_manifestation do |f|
    f.bookmark_stat_id{FactoryBot.create(:bookmark_stat).id}
    f.manifestation_id{FactoryBot.create(:manifestation).id}
  end
end
