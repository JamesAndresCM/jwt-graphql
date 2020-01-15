class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.references :truck, null: false, foreign_key: true
      t.boolean :active
      t.date :dispatch_date
      t.string :start_time, null: true, default: '09:00:00'
      t.integer :minutes_between, null: true, default: 20
      t.string :end_time, null: true, default: '09:00:00'
      t.datetime :started_at, null: true
      t.boolean :ended, default: false, null: true
      t.datetime :ended_at, null: true
      t.references :truck_driver, null: false, foreign_key: true
      t.float :kpi_distance
      t.float :kpi_max_speed
      t.float :kpi_avg_speed
      t.float :kpi_time
      t.float :kpi_stop_time
      t.references :account, null: false, foreign_key: true
      t.boolean :enable_estimations
      t.text :encoded_optimal_path
      t.boolean :start_in_place
      t.text :initial_dispatches_order
      t.integer :planned_distance
      t.integer :real_distance

      t.timestamps
    end
  end
end
