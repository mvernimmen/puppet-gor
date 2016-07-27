require 'spec_helper'

describe 'gor', :type => 'class' do
  let(:upstart_file) { 'gor-conf' }
  let(:facts) { {
    :osfamily                  => 'RedHat',
    :operatingsystem           => 'RedHat',
    :operatingsystemmajrelease => '6',
    :path                      => '/usr/local/bin:/usr/bin:/bin',
  } }

  describe '#args' do
    context 'valid hash, non-alphabetical order' do
      let(:params) {{
        :args => {
          '-output-http-header' => 'User-Agent: gor',
          '-output-http'        => 'http://staging',
          '-input-raw'          => ':80',
        },
      }}

      it { should compile.with_all_deps }

      it 'should configure gor with the correct arguments' do
        should contain_file(upstart_file).with_content(/exec \/usr\/local\/bin\/gor \\\n\s{1,}-input-raw=':80' \\\n\s{1,}-output-http='http:\/\/staging' \\\n\s{1,}-output-http-header='User-Agent: gor'/)
      end
    end

    context 'multiple values' do
      let(:params) {{
        :args => {
          '-input-raw'          => ':80',
          '-output-http'        => 'http://staging',
          '-output-http-method' => [
            'GET', 'HEAD', 'OPTIONS'
          ],
        },
      }}

      it 'should configure gor with the correct arguments' do
        should contain_file(upstart_file).with_content(/exec \/usr\/local\/bin\/gor \\\n\s{1,}-input-raw=':80' \\\n\s{1,}-output-http='http:\/\/staging' \\\n\s{1,}-output-http-method='GET' \\\n\s{1,}-output-http-method='HEAD' \\\n\s{1,}-output-http-method='OPTIONS'/)
      end
    end

    context 'arguments without values' do
      let(:params) {{
        :args => {
          '-input-raw'          => ':80',
          '-output-http'        => 'http://staging',
          '-http-original-host' => '',
        },
      }}

      it 'should not include an equals when the argument has no value' do
        is_expected.to contain_file(upstart_file).with_content(/exec \/usr\/local\/bin\/gor \\\n\s{1,}-http-original-host \\\n\s{1,}-input-raw=':80' \\\n\s{1,}-output-http='http:\/\/staging'/)
      end
    end

    context 'not a hash' do
      let(:params) {{
        :args => 'somestring',
      }}

      it { expect { should compile }.to raise_error(/is not a Hash/) }
    end

    context 'empty hash' do
      let(:params) {{
        :args => {},
      }}

      it { expect { should compile }.to raise_error(/args param is empty/) }
    end
  end

  describe '#envvars' do
    context 'valid hash' do
      let(:params) {{
        :envvars => {
          'GODEBUG' => 'netdns=go',
          'FOO'     => 'bar',
        },
        :args => {
          '-output-http-header' => 'User-Agent: gor',
          '-output-http'        => 'http://staging',
          '-input-raw'          => ':80',
        },
      }}

      it 'should configure gor with correct environment variables in place' do
        is_expected.to contain_file(upstart_file).with_content(/env GODEBUG=\'netdns=go\'\nenv FOO=\'bar\'/)
      end
    end
    context 'empty hash' do
      let(:params) {{
        :envvars => {},
        :args => {
          '-output-http-header' => 'User-Agent: gor',
          '-output-http'        => 'http://staging',
          '-input-raw'          => ':80',
        },
      }}

      it 'should configure gor without setting environment variables' do
        is_expected.not_to contain_file(upstart_file).with_content(/env GODEBUG=\'netdns=go\'\nenv FOO=\'bar\'/)
      end
    end
  end
end
