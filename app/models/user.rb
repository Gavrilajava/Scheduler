class User < ApplicationRecord

  has_secure_password

  has_one :setting

  before_destroy :check_last

  ROLES = ['User', "Viewer", 'Admin']
  validates :email, :name, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :role, presence: true, inclusion: { in: ROLES }
  validate :password_complexity
  validate :at_least_one_admin, on: :update

  scope :admins, -> {where(role: "Admin")}


  def password_complexity
    if self.password
      symbols = 0
      if self.password.match(/[0-9]/)
        symbols += 10
      end
      if self.password.match(/[a-z]/)
        symbols += 26
      end
      if self.password.match(/[A-Z]/)
        symbols += 26
      end
      if self.password.match(/[$&+,:;=?@#|'<>.^*()%!-]/)
        symbols += 22
      end
      if self.password.length**symbols < 7237005577332262213973186563042994240829374041602535252466099000494570602496
        errors.add(:password, "should be more complex")
      end
    end
  end

  def at_least_one_admin
    admins = User.admins
    if !self.admin && admins.first == self && admins.count == 1
      errors.add("There", "should left at least one admin")
    end
  end

  def check_last
    admins = User.admins
    if admins.first == self && admins.count == 1
      errors.add("There", "should left at least one admin")
      throw(:abort)
    end
  end

  def admin
    self.role == 'Admin'
  end

end
