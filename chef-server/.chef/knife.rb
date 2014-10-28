current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                'zvickery'
client_key               '/Users/zvickery/dev/bsu-cloud-computing/chef-server/.chef/zvickery.pem'
validation_client_name   'validation.pem'
validation_key           '/Users/zvickery/dev/bsu-cloud-computing/chef-server/.chef/validation.pem'
#chef_server_url          'https://chef.zdvickery.us/organizations/zdv'
chef_server_url          'https://api.opscode.com/organizations/zdv'
syntax_check_cache_path  '/Users/zvickery/dev/bsu-cloud-computing/chef-server/.chef/syntax_check_cache'
cookbook_path            ["#{current_dir}/../cookbooks"]
