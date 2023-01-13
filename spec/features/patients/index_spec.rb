require 'rails_helper'

RSpec.describe 'patients index page' do
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

  it 'lists all adult patients in alphabetical order' do
    visit patients_path

    expect(@patient2.name).to appear_before(@patient1.name)
    expect(@patient1.name).to appear_before(@patient3.name)
    expect(page).to_not have_content(@patient4.name)
    expect(page).to have_content(@patient1.name, count: 1)
  end

end
