class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.references :service_request, null: false, foreign_key: true
      t.string :data

      t.timestamps
    end
  end
end
