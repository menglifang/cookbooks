#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#
# Copyright 2012, Beijing Menglifang Network Science and Technology Co.,Ltd.
#
# MIT License

include_recipe "git"
include_recipe "zsh"

search( :users, "shell:*zsh" ).each do |u|
  user_id = u["id"]

  git "/home/#{user_id}/.oh-my-zsh" do
    repository "https://github.com/robbyrussell/oh-my-zsh.git"
    reference "master"
    user user_id
    group user_id
    action :checkout
    not_if "test -d /home/#{user_id}/.oh-my-zsh"
  end

  theme = data_bag_item( "users", user_id )["oh-my-zsh-theme"]

  template "/home/#{user_id}/.zshrc" do
    source "zshrc.erb"
    owner user_id
    group user_id
    variables( :theme => ( theme || node[:ohmyzsh][:theme] ))
    action :create_if_missing
  end
end
