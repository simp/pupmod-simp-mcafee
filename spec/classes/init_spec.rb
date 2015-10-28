require 'spec_helper'

describe 'mcafee' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      let(:facts) {{
        :hardwaremodel => 'x86_64',
        :rsync_server  => 'test_server.example.domain',
        :rsync_timeout => '60'
      }}

  context "on #{os}" do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to create_class('mcafee') }

      context 'base' do 
        it { is_expected.to contain_package('mcafee-uvscan64').with(:ensure =>'latest') }
        it { is_expected.to create_file('/opt/mcafee_dat').that_requires('Package[mcafee-uvscan64]') }
      end
    end
  end
 end
end



