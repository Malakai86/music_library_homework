require("pry-byebug")
require_relative('../models/artist')
require_relative('../models/album')

# Album.delete_all()
# Artist.delete_all()

artist1 = Artist.new(
  {
    'artist_name' => 'Pink Floyd'
  }
)
artist1.save()

album1 = Album.new(
  {
    'artist_id' => artist1.id,
    'album_title' => 'The Wall',
    'album_genre' => 'Prog Rock'
  }
)
album1.save()

album2 = Album.new(
  {
    'artist_id' => artist1.id,
    'album_title' => 'Wish You Where Here',
    'album_genre' => 'Prog Rock'
  }
)
album2.save()

binding.pry
nil
