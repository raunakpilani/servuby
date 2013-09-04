require 'sinatra'

get '/', :agent => /(Windows)/ do
  puts "--#{params[:agent]}--"
  erb :home
end

get '/:browser/:command', :agent => /.*/ do
  begin
    erb "#{params[:browser]}/#{params[:command]}#{params[:proxy] == "true" ? "-proxy" : ""}".to_sym
  rescue Errno::ENOENT => msg
    "#{msg}"
  end
end
