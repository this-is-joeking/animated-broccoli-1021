require 'rails_helper'

RSpec.describe Patient do
  before(:each) do
    @grey = Hospital.create(name: 'Grey Sloan Memorial Hospital')
    @meredith = @grey.doctors.create!(name: 'Meredith Gray', specialty: 'General Surgery', university: 'Harvard')
    @alex = @grey.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins')
    @patient1 = @meredith.patients.create!(name: 'Katie Bryce', age: 24)
    @patient2 = @meredith.patients.create!(name: 'Denny Duquette', age: 39)
    @patient3 = @meredith.patients.create!(name: 'Rebecca Pope', age: 32)
    @patient4 = @meredith.patients.create!(name: 'Zola Sheperd', age: 2)
    PatientDoctor.create!(doctor: @alex, patient: @patient1)
  end

  describe 'relationships' do
    it {should have_many :patient_doctors}
    it {should have_many(:doctors).through(:patient_doctors)}
  end

  describe '.sort_alpha' do
    it 'sorts all patients alphabetically' do
      expect(Patient.sort_alpha).to eq([@patient2, @patient1, @patient3, @patient4])

      patient5 = Patient.create!(name: 'Aaron A Aaronson', age: 35)

      expect(Patient.sort_alpha).to eq([patient5, @patient2, @patient1, @patient3, @patient4])
    end
  end

  describe '.over_18' do
    it 'returns patients that are over 18 only' do
      expect(Patient.over_18.sort).to eq([@patient2, @patient1, @patient3].sort)

      patient5 = Patient.create!(name: 'Aaron A Aaronson', age: 35)
      patient6 = Patient.create!(name: 'Billy Bob', age: 10)

      expect(Patient.over_18.sort).to eq([@patient2, @patient1, @patient3, patient5].sort)
    end
  end
end