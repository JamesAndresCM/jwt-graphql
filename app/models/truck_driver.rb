class TruckDriver < ApplicationRecord
  belongs_to :truck
  belongs_to :account
  has_many :routes, dependent: :destroy
  has_many :truck_driver_availabilities, dependent: :destroy

  validates :name, presence: true
  validates :username, format: { without: /\s/ }, presence: true
  validates :pin_code, length: 4..4, presence: true
  validates :account_id, presence: true
  validates :truck_id, allow_nil: true, uniqueness: { scope: :truck_id }

  def self.candidates_to_assign_guide(account, place)
    latitude_start = place.latitude - 0.05
    latitude_end = place.latitude + 0.05
    longitude_start = place.longitude - 0.05
    longitude_end = place.longitude + 0.05

    TruckDriver.find_by_sql(["SELECT * FROM
      (SELECT
        truck_drivers.id AS td_id,
            truck_driver_availabilities.id AS tda_id,
            truck_driver_availabilities.created_at AS tda_created_at,
            truck_driver_availabilities.latitude AS tda_lat,
            truck_driver_availabilities.longitude AS tda_long
        FROM truck_drivers
        INNER JOIN truck_driver_availabilities ON truck_driver_availabilities.truck_driver_id = truck_drivers.id
        WHERE
          (truck_driver_availabilities.created_at BETWEEN ? AND ? ) AND
          (truck_driver_availabilities.latitude BETWEEN ? AND ? ) AND
          (truck_driver_availabilities.longitude BETWEEN ? AND ? ) AND
          truck_driver_availabilities.available = TRUE
          AND truck_driver_availabilities.id = (SELECT MAX(truck_driver_availabilities.id)
            FROM truck_driver_availabilities
            WHERE truck_driver_availabilities.truck_driver_id = truck_drivers.id)
          AND truck_drivers.account_id = ?
    GROUP BY truck_drivers.id, truck_driver_availabilities.id) AS sub
  ORDER BY tda_created_at DESC", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day, latitude_start, latitude_end, longitude_start, longitude_end, account.id])
               .pluck(:tda_id, :td_id, :tda_lat, :tda_long, :tda_created_at)
  end
end
