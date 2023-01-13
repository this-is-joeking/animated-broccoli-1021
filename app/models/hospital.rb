class Hospital < ApplicationRecord
  has_many :doctors

  def doctors_with_patient_count
    self.doctors.left_joins(:patient_doctors)
                .select('doctors.*, count(patient_doctors) as patient_count')
                .group(:id).order(patient_count: :desc)
  end
end
