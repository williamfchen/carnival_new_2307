class Ride
  attr_reader :name, 
              :min_height, 
              :admission_fee, 
              :excitement, 
              :rider_log

  def initialize(ride_details)
    @name = ride_details[:name]
    @min_height = ride_details[:min_height]
    @admission_fee = ride_details[:admission_fee]
    @excitement = ride_details[:excitement]
    @rider_log = {}
  end
  
  def board_rider(rider)
    if rider.tall_enough?(@min_height) && rider.preferences.include?(@excitement) && rider.spending_money >= @admission_fee
      rider.spending_money -= @admission_fee
      @rider_log[rider] = @rider_log[rider].to_i + 1
    end
  end
  
  def total_revenue
    @rider_log.values.reduce(0, :+)
  end
  
end
