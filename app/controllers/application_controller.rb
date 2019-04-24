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

  post '/recipes' do
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do |id|
    @recipe = Recipe.find(id)
    erb :show
  end

  get '/recipes/:id/edit' do |id|
    @recipe = Recipe.find(id)
    erb :edit
  end

  patch '/recipes/:id' do |id|
    recipe = Recipe.find(id)
    recipe.update(params)
    redirect "/recipes/#{id}"
  end

  delete '/recipes/:id' do |id|
    recipe = Recipe.find(id)
    recipe.destroy
    redirect '/recipes'
  end




end
