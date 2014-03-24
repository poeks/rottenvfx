Sequel.migration do
  up do

    create_table(:movies) do

      primary_key :id

      column :url, String, :length => 255
      column :year, String, :length => 4
      column :title, String, :length => 100
      column :critics_rating, String, :length => 25
      column :consensus, :text
      column :critics_score, Integer

      column :created_at, :timestamp
      column :updated_at, :timestamp

    end

  end

  down do
    drop_table(:movies)
  end

end
