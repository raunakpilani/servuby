require 'sinatra'

get '/' do
  erb :home
end

get '/:browser/:command' do
  begin
    erb "#{params[:browser]}/#{params[:command]}#{params[:proxy] == "true" ? "-proxy" : ""}".to_sym
  rescue Errno::ENOENT => msg
    "#{msg}"
  end
end
