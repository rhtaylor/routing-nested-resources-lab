class SongsController < ApplicationController
  def index 
       @response = Artist.exists?(id: params[:artist_id]) 
      
        if @response == false && params.include?(:artist_id)
          flash[:alert] = "Artist not found."
          redirect_to artists_path
        else 
          @songs = Song.all 
        end
  end

  def show  
    @answer = Song.exists?(id: params[:id]) 
   if @answer 
       @song = Song.find(params[:id]) 
    
   else  
     flash[:alert] = "Song not found." 
     @artist = Artist.find(params[:artist_id])
     redirect_to artist_songs_path(@artist)
   end 
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

