class AssignRoles < ActiveRecord::Migration
  def self.up
    User.find_by_login("admin").has_role!(:admin)
  end

  def self.down
    User.find_by_login("admin").has_no_roles!
  end
end
