module Danica
  class Function::Spatial < Function
    variables :time, :acceleration, :initial_space, :initial_velocity

    private

    def function_block
      @function_block ||= Sum.new(parcels)
    end

    def parcels
      [
        initial_space,
        spatial_velocity,
        spatial_acceleration
      ]
    end

    def spatial_velocity
      Product.new(initial_velocity, time)
    end

    def spatial_acceleration
      Division.new(Product.new(acceleration, time_squared), 2)
    end

    def time_squared
      Power.new(time, 2)
    end
  end
end
