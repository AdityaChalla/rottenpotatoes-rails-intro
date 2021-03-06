
class MoviesController < ApplicationController
  

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

    @sorted_by = nil
    @ratings_on = {"G"=>"1", "PG" => "1", "PG-13"=>"1", "R"=>"1"}
  
    
    if params[:sort]
      @sorted_by = params[:sort]
      session[:sort] = @sorted_by
    end
    if params[:ratings]
      @ratings_on = params[:ratings]
      session[:rate] = @ratings_on
    end 
    
    if !@sorted_by.nil? and !@ratings_on.nil?
      @movies = Movie.where(:rating => @ratings_on.keys).order(@sorted_by)
    elsif !@sorted_by.nil?
      @movies = Movie.order(@sorted_by)
    elsif !@ratings_on.nil?
      @movies = Movie.where(:rating => @ratings_on.keys)
    else
      @movies = Movie.all
    end


  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
