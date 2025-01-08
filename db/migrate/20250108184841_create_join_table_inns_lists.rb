class CreateJoinTableInnsLists < ActiveRecord::Migration[5.2]
  def change
    create_join_table :inns, :lists do |t|
      t.index [:inn_id, :list_id]
    end
  end
end