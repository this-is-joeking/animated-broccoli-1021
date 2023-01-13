class PatientsController < ApplicationController
  def index
    @patients = Patient.sort_alpha.over_18
  end
end