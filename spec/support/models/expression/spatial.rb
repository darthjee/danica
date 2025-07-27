# frozen_string_literal: true

module Danica
  module Expression
    class Spatial < Expression.build(:time, :acceleration, :initial_space, :initial_velocity) do
      addition(parcels)
    end

      private

      def parcels
        [
          initial_space,
          spatial_velocity,
          spatial_acceleration
        ]
      end

      def spatial_velocity
        multiplication(initial_velocity, time)
      end

      def spatial_acceleration
        division(multiplication(acceleration, time_squared), 2)
      end

      def time_squared
        power(time, 2)
      end
    end
  end
end
