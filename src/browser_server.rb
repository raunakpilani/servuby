require 'socket'

class BrowserServer

  FIREFOX_EXEC = "/Applications/firefox.app/Contents/MacOS/firefox"
  FIREFOX_PROFILE = "/Users/raunakpilani/Library/Application Support/Firefox/Profiles"
  CHROME_EXEC = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  CHROME_PROFILE = "/Users/raunakpilani/Library/Application Support/Google/Chrome/Profile 1"
  SAFARI_EXEC = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  SAFARI_PROFILE = "/Users/raunakpilani/Library/Application Support/Google/Chrome/Profiles"

  def initialize(port)
    @port = port
    @server = nil
    @running = {}
  end
  
  def server_start
    @server = TCPServer.open(@port)
    puts "#{@server.addr} is listening since #{Time.now}"

    while true do
      Thread.start(@server.accept) do |client_sock|
        puts "#{client_sock} created on #{Time.now}"
        client_line = client_sock.readline
        browser_code,command = client_line.split(' ')[1].split('/')[1,2] if client_line.include? "HTTP"
        client_sock.write(execute(browser_code,command)) if browser_code && command
        puts "#{client_sock} destroyed on #{Time.now}" 
        client_sock.close
      end
    end
  end 

  def execute(browser_code,command)
    puts "Request received as: #{browser_code} #{command}"
    begin
      return send("#{command}_#{browser_code}")
    rescue NoMethodError => msg
      puts msg
    end
  end

  def start_mf
    puts "starting mf"
    @running["firefox"] = @running["firefox"].to_a << spawn("#{FIREFOX_EXEC} -p empty")
    "Firefox is running as pid: #{@running["firefox"].last}"
  end

  def clean_mf
    puts "cleaning mf"
    unless @running["firefox"].to_a.last
      `./clean_firefox.sh`
    else
      return "Cant clean if browser is running"
    end
    "MF profile has been cleaned"
  end

  def close_mf
    puts "closing mf"
    process_object = @running["firefox"].to_a.pop
    Process.kill(9,process_object) if process_object
    "process #{process_object} for mf is no more!"
  end

end

