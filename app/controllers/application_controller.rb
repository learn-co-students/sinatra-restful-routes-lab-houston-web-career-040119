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
    current_recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{current_recipe.id}"
  end

  delete '/recipes/:id' do
    current_recipe.destroy
  end



  post '/recipes' do
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end

  def current_recipe
    Recipe.find(params[:id])
  end

end
