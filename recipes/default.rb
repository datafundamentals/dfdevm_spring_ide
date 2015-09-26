#
# Cookbook Name:: dfdevm_springIDE
# Recipe:: default
#
# Pete Carapetyan
Chef::Log.warn("\n.\n.\n.\n.\n.\n.\n.\nIF YOU DO NOT HAVE A FOLDER NAMED 'shuttle' IN YOUR HOME DIRECTORY THIS CHEF RUN WILL BARF\n.\n.\n.\n.\n.\n.\n.\n")
include_recipe "df_java::default"
include_recipe "df_maven::default"
include_recipe "df_spring_ide::default"

docker_service 'default' do
  action [:create, :start]
end

docker_image 'busybox' do
  action :pull
end

docker_container 'an echo server' do
  repo 'busybox'
  port '1234:1234'
  command "nc -ll -p 1234 -e /bin/cat"
end


execute "chown docker.sock" do 
    command "chown -R vagrant:vagrant /run/docker"
    command "chown -R vagrant:vagrant /run/docker.sock"
    action :run
end