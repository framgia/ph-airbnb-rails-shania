class Relationship < ApplicationRecord
  belongs_to :guest, class_name: "User"
  belongs_to :host, class_name: "User"
  validates  :guest_id, presence: true
  validates  :host_id, presence: true
end
