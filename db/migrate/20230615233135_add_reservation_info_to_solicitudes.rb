class AddReservationInfoToSolicitudes < ActiveRecord::Migration[7.0]
  def change
    add_column :solicituds, :reservation_info, :string
  end
end
