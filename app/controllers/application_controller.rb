
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @articles = Article.all
    erb :index
    #OR just: redirect to "/articles"
  end

  get '/articles/new' do
    erb :new
  end

  #Create action
  post '/articles' do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  #Read - index action (all)
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  #Read - show action (instance)
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  #Update action (renders update form)
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  #Update action/PATCH request (catches post request sent by form)
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect "/articles/#{@article.id}"
  end

  #delete controller action
  delete '/articles/:id' do
    @article = Article.delete(params[:id])
    redirect "/articles"
  end

end
