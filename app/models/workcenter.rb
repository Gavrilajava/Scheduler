class Workcenter < ApplicationRecord

  validates :code, format: { with: /\A[0-9]{3}\z/, message: "should consist of three digits" }

  scope :sorted, -> {order(:code)}
  scope :groups, -> {distinct.pluck(:group)}

end
