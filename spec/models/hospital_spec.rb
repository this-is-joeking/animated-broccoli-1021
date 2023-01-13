require 'rails_helper'

RSpec.describe Hospital do
  before(:each) do
    @grey = Hospital.create(name: 'Grey Sloan Memorial Hospital')
    @seaside = Hospital.create(name: 'Seaside Health & Wellness Center')
    @meredith = @grey.doctors.create!(name: 'Meredith Gray', specialty: 'General Surgery', university: 'Harvard')
    @alex = @grey.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins')
    @miranda = @grey.doctors.create!(name: 'Miranda Bailey', specialty: 'General Surgery', university: 'Stanford')
    @derek = @grey.doctors.create!(name: 'Derek McDreamy', specialty: 'Attending Surgeon', university: 'University of Pennsylvania')
    @patient1 = @meredith.patients.create!(name: 'Katie Bryce', age: 24)
    @patient2 = @meredith.patients.create!(name: 'Denny Duquette', age: 39)
    @patient3 = @meredith.patients.create!(name: 'Rebecca Pope', age: 32)
    @patient4 = @meredith.patients.create!(name: 'Zola Sheperd', age: 2)
    PatientDoctor.create!(doctor: @alex, patient: @patient4)
    PatientDoctor.create!(doctor: @miranda, patient: @patient2)
    PatientDoctor.create!(doctor: @miranda, patient: @patient1)
    PatientDoctor.create!(doctor: @derek, patient: @patient1)
    PatientDoctor.create!(doctor: @derek, patient: @patient3)
    PatientDoctor.create!(doctor: @derek, patient: @patient2)
  end

  it {should have_many :doctors}

  describe '#doctors_with_patient_count' do
    it 'returns doctors ordered by patient count along with patient count' do
      expect(@grey.doctors_with_patient_count).to eq([@meredith, @derek, @miranda, @alex])
      
      doogie = @grey.doctors.create!(name: 'Doogie Howser', specialty: 'Resident in Surgery', university: 'Princeton')
      
      expect(@grey.doctors_with_patient_count).to eq([@meredith, @derek, @miranda, @alex, doogie])

      expect(@seaside.doctors_with_patient_count).to eq([])
    end
  end
end
