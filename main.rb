# encoding: UTF-8
require 'sinatra'
require 'find'
require 'rdiscount'


# for all markdown files, use post.haml as layout
#set :markdown, :layout_engine => :erb, :layout => :post


def get_files(path)
  files = []
  Find.find(path) do |c|
    files << File.basename(c, ".md") if !File.directory?(c)
  end
  return files
end

get '/' do
  @posts = get_files('./views/posts/')
  erb :index
end

get '/visualizar/:post/?' do
  halt 404 unless File.exist?("views/posts/#{params[:post]}.md")
  markdown :"posts/#{params[:post]}"
end

not_found do
  erb :"404"
end

