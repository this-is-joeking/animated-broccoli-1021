require 'rails_helper'

RSpec.describe 'doctors show page' do
  before(:each) do
    @grey = Hospital.create(name: 'Grey Sloan Memorial Hospital')
    @meredith = @grey.doctors.create!(name: 'Meredith Gray', specialty: 'General Surgery', university: 'Harvard')
    @patient1 = @meredith.patients.create!(name: 'Katie Bryce', age: 24)
    @patient2 = @meredith.patients.create!(name: 'Denny Duquette', age: 39)
    @patient3 = @meredith.patients.create!(name: 'Rebecca Pope', age: 32)
    @patient4 = @meredith.patients.create!(name: 'Zola Sheperd', age: 2)
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
    save_and_open_page
    @meredith.patients.each do |patient|
      expect(page).to have_content(patient.name)
    end
  end
end
