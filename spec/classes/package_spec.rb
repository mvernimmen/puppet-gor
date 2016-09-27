require 'spec_helper'

describe 'gor', :type => 'class' do
  let(:facts) { {
    :operatingsystem           => 'RedHat',
    :osfamily                  => 'RedHat',
    :operatingsystemmajrelease => '6'
  } }

  describe '#package_ensure' do
    context 'default' do
      let(:params) {{
        :args => { '--foo' => 'bar' },
      }}

      it { should contain_archive('gor-0.15.1').with_ensure('present') }
    end

    context '1.2.3' do
      let(:params) {{
        :args => { '--foo' => 'bar' },
        :version => '1.2.3',
      }}

      it { should contain_archive('gor-1.2.3').with(:url => 'https://github.com/buger/gor/releases/download/v1.2.3/gor_v1.2.3_x64.tar.gz') }
    end
  end
end
