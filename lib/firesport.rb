module Firesport
  INVALID_TIME = 99_999_999

  module TimeInvalid
    extend ActiveSupport::Concern

    included do
      scope :valid, -> { where.not(time: INVALID_TIME) }
      scope :invalid, -> { where(time: INVALID_TIME) }
    end

    def time_invalid?
      time >= INVALID_TIME
    end
  end

  class Time
    def self.second_time(time)
      return 'D' if (time.is_a?(Float) || time.is_a?(BigDecimal)) && time.nan?
      return 'D' if time.blank?
      return 'D' if time >= INVALID_TIME

      seconds = time.to_i / 100
      deci = time.to_i % 100
      "#{seconds},#{format('%02d', deci)}"
    end
  end
end
