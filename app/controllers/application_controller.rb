class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = current_recipe
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = current_recipe
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = current_recipe
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  post '/recipes' do
    new_recipe = Recipe.create(params)
    redirect "/recipes/#{new_recipe.id}"
  end

  delete '/recipes/:id' do
    current_recipe.delete
    redirect '/recipes'
  end

  def current_recipe
    Recipe.find_by_id(params[:id])
  end

end
