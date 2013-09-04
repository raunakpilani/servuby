require 'sinatra'

get '/' do
  erb :home
end

get '/:browser/:command', :agent => /(Windows|Macintosh)/ do
  begin
    erb "#{params[:agent][0].downcase}/#{params[:browser]}/#{params[:command]}#{params[:proxy] == "true" ? "-proxy" : ""}".to_sym
  rescue Errno::ENOENT => msg
    "#{msg}"
  end
end
