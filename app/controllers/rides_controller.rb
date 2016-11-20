class RidesController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @rides = current_user.rides.includes(:company)
    @rides_summary = Ride.select("date, ARRAY_AGG(company_id) as company_ids, AVG(distance) as avg_distance, SUM(distance) as sum_distance, AVG(payment_amount) as avg_payment_amount").group(:date).order(date: :desc)
  end

  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.user = current_user
    if @ride.save
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
    params.require(:ride).permit(:date, :start_address, :destination_address, :payment_amount, :company_id)
  end
end