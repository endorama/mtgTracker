
# - helper function -

def download(url, location)
  require 'open-uri'
  open(location, 'wb') do |file|
    file << open(url).read
  end
end

def download_and_extract(url, location)
  require 'open-uri'
  require 'zip'

  tmp = Tempfile.new 'allsets'
  
  open(tmp.path, 'wb') do |file|
    file << open(url).read
  end

  Zip::File.open(tmp.path) do |zipfile|
    zipfile.extract(location, location)
  end

  tmp.unlink
end

def file_age(file)
  if File.exists? file
    file_age = (File.stat(file).ctime).to_date
    today = Date.today
    return (today - file_age).to_int
  else
    return 1000
  end
end

def parse_json(file)
  require 'json'
  JSON.parse(IO.read(file), symbolize_names: true)
end
