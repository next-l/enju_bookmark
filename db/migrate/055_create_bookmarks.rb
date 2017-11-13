class CreateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks, force: true, type: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :user, null: false, foreign_key: true
      t.references :manifestation, null: false, foreign_key: true, type: :uuid
      t.text :title
      t.string :url, index: true, null: false
      t.text :note
      t.boolean :shared, null: false, default: false

      t.timestamps
    end
  end
end
