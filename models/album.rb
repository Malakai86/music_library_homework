require_relative('../db/sql_runner')
require_relative('./artist')

class Album
  attr_reader :id
  attr_accessor :album_title, :album_genre

  def initialize(options)
    @album_title = options['album_title']
    @album_genre = options['album_genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_hash = results[0]
    artist = Artist.new(artist_hash)
    return artist
  end

  def save()
    sql = "INSERT INTO albums (
    artist_id,
    album_title,
    album_genre
    )
    VALUES
    (
    $1, $2, $3
    )
    RETURNING id"
    values = [@artist_id, @album_title, @album_genre]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end
end
