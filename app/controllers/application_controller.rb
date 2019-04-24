class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/' do
    redirect "/recipes"
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :"index"
  end

  get '/recipes/new' do
    erb :"new"
  end

  get '/recipes/:id' do
    @id = params[:id].to_i
    @recipe = Recipe.find(@id)
    erb :"show"
  end

  get '/recipes/:id/edit' do
    @id = params[:id].to_i
    @recipe = Recipe.find(@id)
    erb :"edit"
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params["name"], \
      ingredients: params["ingredients"], cook_time: params["cook_time"])
    redirect "/recipes/#{@recipe.id}"
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find( params[:id].to_i )
    @recipe.update( name: params["name"], \
      ingredients: params["ingredients"], cook_time: params["cook_time"] )
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find( params[:id].to_i )
    @recipe.destroy
    redirect "/recipes"
  end

end
