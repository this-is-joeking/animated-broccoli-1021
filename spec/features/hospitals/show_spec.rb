require 'rails_helper'

RSpec.describe 'hospital show page' do
  before(:each) do
    @grey = Hospital.create(name: 'Grey Sloan Memorial Hospital')
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

  it 'lists all docs and their patient count ordered by patient count' do
    visit hospital_path(@grey)

    expect(page).to have_content('Dr. Meredith Gray (4 patients)')
    expect(page).to have_content('Dr. Alex Karev (1 patients)')
    expect(page).to have_content('Dr. Miranda Bailey (2 patients)')
    expect(page).to have_content('Dr. Derek McDreamy (3 patients)')

    expect(@meredith.name).to appear_before(@derek.name)
    expect(@derek.name).to appear_before(@miranda.name)
    expect(@miranda.name).to appear_before(@alex.name)
  end

  
end

# As a visitor
# When I visit a hospital's show page
# I see the hospital's name
# And I see the names of all doctors that work at this hospital,
# And next to each doctor I see the number of patients associated with the doctor,
# And I see the list of doctors is ordered from most number of patients to least 
# number of patients
# (Doctor patient counts should be a single query)
