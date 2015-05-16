require 'spec_helper'

describe 'mcafee' do

  let(:facts) {{
    :hardwaremodel => 'x86_64',
    :rsync_server  => 'test_server.example.domain',
    :rsync_timeout => '60'
  }}

  it { should create_class('mcafee') }
  it { should compile.with_all_deps }
  it { should contain_package('mcafee-uvscan64') }
  it { should create_file('/opt/mcafee_dat') }
end
