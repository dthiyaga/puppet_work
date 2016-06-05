# Query devops for exported mount points for this host.

require 'open-uri'
require 'timeout'

def fetch_data()
    hostname = Facter.value('hostname')
    if File.exist? '/var/tmp/test.data'
        uri = '/var/tmp/test.data'
        puts "URI: #{uri}"
    else
        uri = "http://devops.oraclecorp.com/host/api/#{hostname}/facter/"
    end
    Facter.add('devops_uri') { setcode { uri } }

    data = open(uri).read
    data.split("\n").each do |o|
        key, value = o.split('=')
        symbol = "devops_#{key}"
        Facter.add(symbol) { setcode { value } }
    end
end

begin
    begin
        Facter.lsbdistid
    rescue 
        Facter.loadfacts()
    end
    Timeout::timeout(10) { fetch_data }
rescue Timeout::Error
    #puts "devops-metadata not loaded"
end


