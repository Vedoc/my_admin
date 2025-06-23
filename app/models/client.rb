class Client < ApplicationRecord
  has_many :vehicles, dependent: :destroy
end
