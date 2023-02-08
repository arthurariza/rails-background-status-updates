class Import < ApplicationRecord
  enum status: {
    'queued' => 0,
    'processing' => 1,
    'completed' => 2,
    'error' => 3
  }

  validates :status, inclusion: statuses.keys
  # after_update_commit :broadcast_update

  private

  def broadcast_update
    broadcast_replace_to 'imports', target: "import_#{id}", partial: 'imports/import'
  end
end
