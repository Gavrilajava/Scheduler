class User < ApplicationRecord

  has_secure_password

  ROLES = ['User', "Viewer", 'Admin']
  validates :email, :name, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: ROLES }

  def admin
    self.role == 'Admin'
  end

end
