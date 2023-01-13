require 'rails_helper'

RSpec.describe 'doctors show page' do
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

  it 'shows all the docs attributes' do
    visit doctor_path(@meredith)

    expect(page).to have_content(@meredith.name)
    expect(page).to have_content(@meredith.specialty)
    expect(page).to have_content(@meredith.university)
  end

  it 'names the hospital where the doc works' do
    visit doctor_path(@meredith)

    expect(page).to have_content(@grey.name)
  end

  it 'lists the docs patients' do
    visit doctor_path(@meredith)

    @meredith.patients.each do |patient|
      expect(page).to have_content(patient.name)
    end
  end

  describe 'removing patient from a doctors caseload' do
    it 'has a button that removes patient from doctors caseload' do
      visit doctor_path(@alex)

      expect(page).to have_content(@patient1.name)
      
      visit doctor_path(@meredith)

      within "#patient-#{@patient1.id}" do
        click_button "Remove Patient"
      end

      expect(current_path).to eq(doctor_path(@meredith))
      expect(page).to_not have_content(@patient1.name)

      visit doctor_path(@alex)
      expect(page).to have_content(@patient1.name)
    end
  end
end
