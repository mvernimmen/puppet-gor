require 'spec_helper'

describe 'gor' do
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
  end
end
