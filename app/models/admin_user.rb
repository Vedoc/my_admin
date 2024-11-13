class AdminUser < ApplicationRecord
  rolify
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  def self.ransackable_attributes(auth_object = nil)
    %w[id email current_sign_in_at sign_in_count created_at]
  end

  private

  def assign_default_role
    add_role(:viewer) if roles.blank?
  end
end
