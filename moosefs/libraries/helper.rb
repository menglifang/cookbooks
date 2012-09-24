module Moosefs
  [:master, :metalogger, :chunk].each do |r|
    define_method "install_#{r}".to_sym do
      install_pkgs
      download
      install
      send("config_#{r}".to_sym)
    end
  end

  def install_pkgs
    if platform? 'ubuntu', 'debian'
      ['build-essential', 'zlib1g-dev'].each { |p| package p }
    end
  end

  def download
    remote_file "#{Chef::Config[:file_cache_path]}/mfs-#{node[:moosefs][:version]}.gz" do
      source "http://dev.menglifang.org/repos/src/moosefs/mfs-#{node[:moosefs][:version]}.gz"
      notifies :run, "bash[install_moosefs]", :immediately
    end
  end

  def install
    bash "install_moosefs" do
      user "root"
      cwd Chef::Config[:file_cache_path]
      code <<-EOH
        groupadd mfs
        useradd -g mfs mfs

        tar -zxf mfs-#{node[:moosefs][:version]}.gz

        (cd mfs-#{node[:moosefs][:version]}/ && ./configure --prefix=/usr    \
        --sysconfdir=/etc --localstatedir=/var/lib --with-default-user=mfs   \
        --with-default-group=mfs                                             \
        #{"--disable-mfschunkserver --disable-mfsmount" if node[:moosefs][:role] =~ /^(master|metalogger)$/} \
        #{"--disable-mfsmaster" if node[:moosefs][:role] == 'chunk'} && make && make install)
      EOH
      action :nothing
      notifies :run, "bash[config_moosefs_#{node[:moosefs][:role]}]", :immediately
    end
  end

  def config_master
    bash "config_moosefs_master" do
      user "root"
      code <<-EOH
        cd /etc
        cp mfsmaster.cfg.dist mfsmaster.cfg
        cp mfsmetalogger.cfg.dist mfsmetalogger.cfg
        cp mfsexports.cfg.dist mfsexports.cfg

        cd /var/lib/mfs
        cp metadata.mfs.empty metadata.mfs
      EOH
      action :nothing
    end
  end

  def config_metalogger
    bash "config_moosefs_metalogger" do
      user "root"
      code <<-EOH
        cd /etc
        cp mfsmetalogger.cfg.dist mfsmetalogger.cfg
      EOH
      action :nothing
    end
  end

  def config_chunk
    bash "config_moosefs_chunk" do
      user "root"
      code <<-EOH
        cd /etc
        cp mfschunkserver.cfg.dist mfschunkserver.cfg
        cp mfshdd.cfg.dist mfshdd.cfg
      EOH
      action :nothing
    end
  end
end

Chef::Recipe.send(:include, Moosefs)
