def whyrun_supported?
  true
end

use_inline_resources

action :enable do
  converge_by('macosx autologin enable') do
    cookbook_file 'autologin.pl' do
      path "#{Chef::Config[:file_cache_path]}/autologin.pl"
      cookbook 'macosx_autologin'
      mode '0755'
      action :create
    end

    restart_loginwindow = new_resource.restart_loginwindow ? 1 : 0
    execute 'enable automatic login' do # ~FC009
      command "sudo #{Chef::Config[:file_cache_path]}/autologin.pl "\
        "#{new_resource.username} #{new_resource.password} #{restart_loginwindow}"
      sensitive true
    end
  end
end

action :disable do
  converge_by('macosx autologin disable') do
    execute 'delete autoLoginUser from com.apple.loginwindow' do
      command "sudo defaults delete /Library/Preferences/com.apple.loginwindow \"autoLoginUser\""
      returns [0, 1]
    end

    execute 'delete /etc/kcpassword' do
      command 'sudo rm -f /etc/kcpassword'
    end
  end
end
