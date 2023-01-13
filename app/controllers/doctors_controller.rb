class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all
  end

  def show
    @doctor = Doctor.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    doctor = Doctor.find(params[:id])
    patient = Patient.find(params[:patient_id])
    doctor.patients.delete(patient)

    redirect_to doctor_path(doctor)
  end

  def destroy
  end

  private

  def doctor_params
    params
  end
end