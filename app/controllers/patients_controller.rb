class PatientsController < ApplicationController
  def index
    @patients = Patient.sort_alpha.over_18
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def patient_params
    params
  end
end