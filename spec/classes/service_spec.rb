require 'spec_helper'

describe 'gor', :type => 'class' do
  let(:facts) { {
    :operatingsystem           => 'RedHat',
    :osfamily                  => 'RedHat',
    :operatingsystemmajrelease => '6'
  } }

  describe '#service_ensure' do
    context 'default' do
      let(:params) {{
        :args => { '--foo' => 'bar' },
      }}

      it {
        should contain_service('gor').with(
          :ensure     => 'running',
          :enable     => 'true',
          :hasrestart => 'false'
        )
      }
    end

    context 'stopped' do
      let(:params) {{
        :args => { '--foo' => 'bar' },
        :service_ensure => 'stopped',
      }}

      it {
        should contain_service('gor').with(
          :ensure     => 'stopped',
          :enable     => 'false',
          :hasrestart => 'false'
        )
      }
    end

    context 'ignored' do
      let(:params) {{
        :args => { '--foo' => 'bar' },
        :service_ensure => 'ignored',
      }}

      it {
        is_expected.not_to contain_service('gor')
      }
    end
  end
end
