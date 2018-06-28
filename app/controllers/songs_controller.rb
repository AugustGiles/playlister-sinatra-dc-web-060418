require 'rack-flash'

class SongsController < ApplicationController

  use Rack::Flash
  enable :sessions
  set :views, 'app/views/songs'

  get '/songs' do
    @songs = Song.all
    erb :index
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :new
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :show
  end

  post '/songs' do
    artist_name = params[:artist][:name]
    song_name = params[:song][:name]

    artist = Artist.new(name: artist_name)
    if Artist.find_by_slug(artist.slug) == nil
      artist.save
      artist.id = Artist.last.id
    else
      artist = Artist.find_by_slug(artist.slug)
    end

    song = Song.create(name: song_name, artist_id: artist.id)

    params[:genres].each do |genre_id|
      song.genres << Genre.find(genre_id)
    end

    flash[:message] = "Successfully created song."
    redirect to "/songs/#{song.slug}"
  end



end
