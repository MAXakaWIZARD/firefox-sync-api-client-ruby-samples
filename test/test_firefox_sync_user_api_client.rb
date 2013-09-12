#!/usr/bin/env ruby
#
# Test class for the Firefox_sync_api_client class
# available at https://github.com/aerostitch/firefox-sync-api-client-ruby-samples
#
# Requires minitest gem. Installed by default with ruby on debian but
# you have to do a "sudo yum install rubygem-minitest" on fedora to install it

require 'test/unit'
require_relative '../firefox_sync_user_api_client.rb'

class Ff_sync_user_api_client < Test::Unit::TestCase

    # As the proxy is optionnal, we test the constructor without proxy
    #
    def test_init_no_proxy()
        puts "[INFO] Testing constructor without proxy settings"
        user_name = 'HelliHello'
        encrypted_user_name = "zfb4oykz7gpe43qkesxjl7j2vn6dcd3u"

        empty_class = Firefox_sync_user_api_client.new(user_name)
        assert_equal(empty_class.ff_srv_scheme, 'https://')
        assert_equal(empty_class.ff_server, 'auth.services.mozilla.com')
        assert_equal(empty_class.ff_user_api_svc, 'user')
        assert_equal(empty_class.ff_misc_api_svc, 'misc')
        assert_equal(empty_class.ff_user_api_version, '1.0')
        assert_equal(empty_class.ff_misc_api_version, '1.0')
        assert_equal(empty_class.user_login, user_name.downcase())
        assert_equal(empty_class.encrypted_login, encrypted_user_name)
        assert_nil(empty_class.http_proxy_uri)
        assert_equal(empty_class.http_proxy_port, 8080)
        assert_nil(empty_class.http_proxy_user)
        # Ensures the proxy password is not available from outside the class
        assert_raise(NoMethodError){empty_class.http_proxy_password}
    end

    # Testing the constructor with an unauthentified proxy
    #
    def test_init_with_proxy_noauth()
        puts "[INFO] Testing constructor with non authenticated proxy"
        user_name = 'HelliHello'
        encrypted_user_name = "zfb4oykz7gpe43qkesxjl7j2vn6dcd3u"
        sample_proxy = "sample.proxy.com"
        sample_proxy_port = 8081

        empty_class = Firefox_sync_user_api_client.new(user_name, sample_proxy,
            sample_proxy_port)
        assert_equal(empty_class.ff_srv_scheme, 'https://')
        assert_equal(empty_class.ff_server, 'auth.services.mozilla.com')
        assert_equal(empty_class.ff_user_api_svc, 'user')
        assert_equal(empty_class.ff_misc_api_svc, 'misc')
        assert_equal(empty_class.ff_user_api_version, '1.0')
        assert_equal(empty_class.ff_misc_api_version, '1.0')
        assert_equal(empty_class.user_login, user_name.downcase())
        assert_equal(empty_class.encrypted_login, encrypted_user_name)
        assert_equal(empty_class.http_proxy_uri, sample_proxy)
        assert_equal(empty_class.http_proxy_port, sample_proxy_port)
        assert_nil(empty_class.http_proxy_user)
        # Ensures the proxy password is not available from outside the class
        assert_raise(NoMethodError){empty_class.http_proxy_password}
    end
    
    # Testing the constructor with an authentified proxy
    #
    def test_init_with_proxy_auth()
        puts "[INFO] Testing constructor with an authenticated proxy"
        user_name = 'HelliHello'
        encrypted_user_name = "zfb4oykz7gpe43qkesxjl7j2vn6dcd3u"
        sample_proxy = "sample.proxy.com"
        sample_proxy_port = 8081
        sample_proxy_user = "mydomain\\myuser"
        sample_proxy_pwd = "APrettyLittlePwd"

        empty_class = Firefox_sync_user_api_client.new(user_name, sample_proxy,
            sample_proxy_port, sample_proxy_user, sample_proxy_pwd)
        assert_equal(empty_class.ff_srv_scheme, 'https://')
        assert_equal(empty_class.ff_server, 'auth.services.mozilla.com')
        assert_equal(empty_class.ff_user_api_svc, 'user')
        assert_equal(empty_class.ff_misc_api_svc, 'misc')
        assert_equal(empty_class.ff_user_api_version, '1.0')
        assert_equal(empty_class.ff_misc_api_version, '1.0')
        assert_equal(empty_class.user_login, user_name.downcase())
        assert_equal(empty_class.encrypted_login, encrypted_user_name)
        assert_equal(empty_class.http_proxy_uri, sample_proxy)
        assert_equal(empty_class.http_proxy_port, sample_proxy_port)
        assert_equal(empty_class.http_proxy_user, sample_proxy_user)
        # Ensures the proxy password is not available from outside the class
        assert_raise(NoMethodError){empty_class.http_proxy_password}
    end
end
