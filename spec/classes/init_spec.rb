require 'spec_helper'

describe 'mcafee' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        base_facts = facts.merge({:spec_title => description})

        describe 'base' do
          let(:facts) { base_facts }
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to create_class('mcafee') }

          it { is_expected.to contain_package('mcafee-uvscan64').with(:ensure =>'latest') }
          it { is_expected.to create_file('/opt/mcafee_dat').that_requires('Package[mcafee-uvscan64]') }
          it { is_expected.to create_rsync('mcafee').with(
            :server  => 'test.example.domain',
            :timeout => '2',
            :source  => 'mcafee/',
            :target  => '/opt/mcafee_dat',
            :delete  => true
          )}
        end
      end
    end
  end
end
