require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'macosx_autologin_test' do
  case os[:family]
  when 'darwin'
    describe file('/etc/kcpassword') do
      it { should_not be_file }
    end

    describe command('sudo defaults read /library/preferences/com.apple.loginwindow') do
      its(:stdout) { should_not match(/autoLoginUser = vagrant/) }
    end
  end
end