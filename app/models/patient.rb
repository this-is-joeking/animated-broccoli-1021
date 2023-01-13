class Patient < ApplicationRecord
  has_many :patient_doctors
  has_many :doctors, through: :patient_doctors

  def self.sort_alpha
    order(:name)
  end

  def self.over_18
    where('age > 17')
  end
end