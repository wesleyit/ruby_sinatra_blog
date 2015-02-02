# encoding: UTF-8
require 'sinatra'
require 'find'
require 'rdiscount'

## Queremos que as páginas e posts markdown utilizem o mesmo
# layout que as páginas
set :markdown, :layout_engine => :erb

## Esta função busca por arquivos na pasta de posts e 
# retorna uma lista com seus nomes.
def get_files(path)
  files = []
  Find.find(path) do |c|
    files << File.basename(c, ".md") if !File.directory?(c)
  end
  return files
end

## O / exibe a home do site, que é o blog com os 
# últimos 10 posts.
get '/' do
  @posts = get_files('./views/posts/')
  erb :index
end

## Quando eu clico em um post, esta rota é chamada para 
# exibí-lo, renderizando seu conteúdo em markdown.
get '/visualizar/:post/?' do
  halt 404 unless File.exist?("views/posts/#{params[:post]}.md")
  markdown :"posts/#{params[:post]}"
end

## A rota /blog redireciona para a home
get "/blog/?" do
	redirect :/
end

## A rota sobre mostra a página com o perfil básico
get "/sobre/?" do
	markdown :sobre
end

## Esta página mostra o perfil profisional
get "/profissional/?" do
	markdown :profissional
end

## Esta página mostra o perfil acadêmico
get "/academico/?" do
	markdown :academico
end

## Esta página mostra o formulário de contato e as redes sociais
get "/contato/?" do
	markdown :contato
end

## Temos que padronizar a página não encontrada, não é?
not_found do
  erb :"404"
end

