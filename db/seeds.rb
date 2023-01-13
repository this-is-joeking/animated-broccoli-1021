# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@grey = Hospital.create(name: 'Grey Sloan Memorial Hospital')

@meredith = @grey.doctors.create!(name: 'Meredith Gray', specialty: 'General Surgery', university: 'Harvard')
@alex = @grey.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins')
@miranda = @grey.doctors.create!(name: 'Miranda Bailey', specialty: 'General Surgery', university: 'Stanford')
@derek = @grey.doctors.create!(name: 'Derek McDreamy', specialty: 'Attending Surgeon', university: 'University of Pennsylvania')
@doogie = @grey.doctors.create!(name: 'Doogie Howser', specialty: 'Resident in Surgery', university: 'Princeton')

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