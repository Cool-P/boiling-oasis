class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  # GET /patients.json
  def index
    @descriptions = Description.all
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
	  @description = Description.find(params[:id])
	  @patient     = @description.patient
  end

  # GET /patients/new
  def new
	  @description = Description.find(params[:id])

	  if @description.patient.nil?
	    @patient = Patient.new
	  else
	    respond_to do |format|
	     format.html { redirect_to "#{description_path}#home", notice: 'Patient Organ Weight is Already Generated.' }
	    end
	  end
  end

  # GET /patients/1/edit
  def edit
     @description = Description.find(params[:id])
     @patient     = @description.patient
  end

  def create

    @description = Description.find(params[:id])
    @description.patient = Patient.new()

    respond_to do |format|
      if @description.patient.save(params[:patient].permit([:name, :dob, :case, :hospital, :age, :date_admission, :race, :sex, :pathologist, :physician, :attendant, :date_autopsy, :time_of_autopsy, :restrictions, :prosector, :time_of_birth, :age_day_week]))
	 format.html { redirect_to "#{description_path}#home", notice: 'Patients Organ weight is  successfully created.' }
	 format.json { render :show, status: :ok, location: @description.patient }
      else
        format.html { render :new }
        format.json { render json: @description.patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    @description = Description.find(params[:id])
    
    respond_to do |format|
      if @description.patient.update(params[:patient].permit([:name, :dob, :case, :hospital, :age, :date_admission, :race, :sex, :pathologist, :physician, :attendant, :date_autopsy, :time_of_autopsy, :restrictions, :prosector, :time_of_birth, :age_day_week]))

        format.html { redirect_to "#{description_path}#home", notice: 'Ronak: Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @description.patient }
      else
        format.html { render :edit }
        format.json { render json: @description.patient.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @description = Description.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :dob, :case, :hospital, :age, :date_admission, :race, :sex, :pathologist, :physician, :attendant, :date_autopsy, :time_of_autopsy, :restrictions, :prosector, :time_of_birth, :age_day_week)
    end
end
