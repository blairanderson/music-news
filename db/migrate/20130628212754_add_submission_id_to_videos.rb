class AddSubmissionIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :submission_id, :integer
    add_index :videos, :submission_id
  end
end
