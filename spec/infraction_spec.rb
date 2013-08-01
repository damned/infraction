require_relative 'spec_helper'
require_relative '../lib/infraction'

describe Infraction do

  describe Infraction::Nginx do

    describe 'proxy' do

      it 'should be able to create nginx config for a real-world proxy pass example' do
        config = Infraction.nginx do
          pass_through('thoughtworks-studios.com').
              including('www').
              on(80).
              forward_to('68.64.190.188')
        end

        config.should match_config 'server {
                                        listen 80;
                                        server_name thoughtworks-studios.com www.thoughtworks-studios.com;

                                        location / {
                                          proxy_pass                        http://68.64.190.188;
                                          proxy_set_header Host             $http_host;
                                        }
                                    }'
      end
    end
  end
end