class CreateSeriesStatements < ActiveRecord::Migration
  def self.up
    create_table :series_statements do |t|
      t.text :original_title
      t.text :numbering
      t.text :title_subseries
      t.text :numbering_subseries
      t.integer :position
      t.text :title_transcription
      t.text :title_alternative

      t.timestamps
    end
  end

  def self.down
    drop_table :series_statements
  end
end
