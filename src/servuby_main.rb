require 'sinatra'

get '/' do
  erb :home
end

get '/:browser/:command' do
  erb "#{params[:browser]}/#{params[:command]}".to_sym
end
