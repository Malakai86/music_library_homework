require_relative('../db/sql_runner')
require_relative('./album')

class Artist

  attr_reader(:id)
  attr_accessor(:artist_name)

def initialize(options)
  @id = options['id'].to_i if options['id']
  @artist_name = options['artist_name']
end

def artists()
  sql = "SELECT * FROM artists WHERE artist_id = $1"
  values = [@id]
  album_hashes = SqlRunner.run(sql, values)
  album_objects = album_hashes.map { |album_hash| Album.new(album_hash) }
  return albums
end

def save()
  sql = "INSERT INTO artists
  (
  artist_name
  )
  VALUES
  (
  $1
  )
  RETURNING *"
  values = [@artist_name]
  returned_array = SqlRunner.run(sql, values)
  artist_hash = returned_array[0]
  id_string = artist_hash['id']
  @id = id_string.to_i
end

def self.all()
  sql = "SELECT * FROM artist"
  album_hashes = SqlRunner.run(sql)
  albums = album_hashes.map{|album| Album.new(album)}
  return albums
end

def self.find(id)
  sql = "SELECT * FROM artist WHERE id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  album_hash = results.first
  album = Album.new(album_hash)
  return albums
end

end
