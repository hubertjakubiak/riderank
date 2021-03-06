class RidesController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @rides = current_user.rides.includes(:company)
    @rides_summary = Ride.select("date, ARRAY_AGG(DISTINCT company_id) as company_ids, AVG(distance) as avg_distance, SUM(distance) as sum_distance, AVG(payment_amount) as avg_payment_amount").group(:date).order(date: :desc)
  end

  def new
    @form = RideForm.new
  end

  def create
    @form = RideForm.new(ride_params.merge!(current_user: current_user))
    if @form.save
      redirect_to root_path, notice: 'Ride was successfully created.'
    else
      render :new
    end
  end

  def edit
    ride
  end

  def update
    if ride.update(ride_params)
      redirect_to root_path, notice: 'Ride was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    ride.destroy
    redirect_to root_path, notice: 'Ride was successfully destroyed.'
  end

  private

  def ride
    @ride ||= Ride.find(params[:id])
  end

  def ride_params
    params.require(:ride_form).permit(:date, :start_address, :destination_address, :payment_amount, :company_id)
  end
end