module Danica
  class Function::Spatial < Function.build(:time, :acceleration, :initial_space, :initial_velocity) { sum(parcels) }

    private

    def parcels
      [
        initial_space,
        spatial_velocity,
        spatial_acceleration
      ]
    end

    def spatial_velocity
      product(initial_velocity, time)
    end

    def spatial_acceleration
      division(product(acceleration, time_squared), 2)
    end

    def time_squared
      power(time, 2)
    end
  end
end
