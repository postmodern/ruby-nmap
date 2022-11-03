require 'spec_helper'
require 'nmap/xml/script'

describe Nmap::XML::Script do
  let(:id) { 'ssh-hostkey' }

  subject { @xml.hosts.first.ports.first.scripts[id] }

  describe "#id" do
    it "must return the 'id' attribute" do
      expect(subject.id).to eq(id)
    end
  end

  describe "#output" do
    it "must return the 'output' attribute" do
      expect(subject.output).to eq(
        [
          '',
          '  1024 ac:00:a0:1a:82:ff:cc:55:99:dc:67:2b:34:97:6b:75 (DSA)',
          'ssh-dss AAAAB3NzaC1kc3MAAACBAOe8o59vFWZGaBmGPVeJBObEfi1AR8yEUYC/Ufkku3sKhGF7wM2m2ujIeZDK5vqeC0S5EN2xYo6FshCP4FQRYeTxD17nNO4PhwW65qAjDRRU0uHFfSAh5wk+vt4yQztOE++sTd1G9OBLzA8HO99qDmCAxb3zw+GQDEgPjzgyzGZ3AAAAFQCBmE1vROP8IaPkUmhM5xLFta/xHwAAAIEA3EwRfaeOPLL7TKDgGX67Lbkf9UtdlpCdC4doMjGgsznYMwWH6a7Lj3vi4/KmeZZdix6FMdFqq+2vrfT1DRqx0RS0XYdGxnkgS+2g333WYCrUkDCn6RPUWR/1TgGMPHCj7LWCa1ZwJwLWS2KX288Pa2gLOWuhZm2VYKSQx6NEDOIAAACBANxIfprSdBdbo4Ezrh6/X6HSvrhjtZ7MouStWaE714ByO5bS2coM9CyaCwYyrE5qzYiyIfb+1BG3O5nVdDuN95sQ/0bAdBKlkqLFvFqFjVbETF0ri3v97w6MpUawfF75ouDrQ4xdaUOLLEWTso6VFJcM6Jg9bDl0FA0uLZUSDEHL',
          '  2048 20:3d:2d:44:62:2a:b0:5a:9d:b5:b3:05:14:c2:a6:b2 (RSA)',
          'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6afooTZ9mVUGFNEhkMoRR1Btzu64XXwElhCsHw/zVlIx/HXylNbb9+11dm2VgJQ21pxkWDs+L6+EbYyDnvRURTrMTgHL0xseB0EkNqexs9hYZSiqtMx4jtGNtHvsMxZnbxvVUk2dasWvtBkn8J5JagSbzWTQo4hjKMOI1SUlXtiKxAs2F8wiq2EdSuKw/KNk8GfIp1TA+8ccGeAtnsVptTJ4D/8MhAWsROkQzOowQvnBBz2/8ecEvoMScaf+kDfNQowK3gENtSSOqYw9JLOza6YJBPL/aYuQQ0nJ74Rr5vL44aNIlrGI9jJc2x0bV7BeNA5kVuXsmhyfWbbkB8yGd',
          '  256 96:02:bb:5e:57:54:1c:4e:45:2f:56:4c:4a:24:b2:57 (ECDSA)',
          'ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBMD46g67x6yWNjjQJnXhiz/TskHrqQ0uPcOspFrIYW382uOGzmWDZCFV8FbFwQyH90u+j0Qr1SGNAxBZMhOQ8pc='
        ].join($/)
      )
    end

    describe "#data" do
      context "when the <script> contains named <table> XML elements" do
        subject { @xml.hosts.first.ports.first.scripts['ssh2-enum-algos'] }

        it "must return a Hash of Hashes" do
          expect(subject.data).to eq(
            {
              'kex_algorithms' => %w[
                curve25519-sha256@libssh.org
                ecdh-sha2-nistp256
                ecdh-sha2-nistp384
                ecdh-sha2-nistp521
                diffie-hellman-group-exchange-sha256
                diffie-hellman-group-exchange-sha1
                diffie-hellman-group14-sha1
                diffie-hellman-group1-sha1
              ],

              'server_host_key_algorithms' => %w[
                ssh-rsa
                ssh-dss
                ecdsa-sha2-nistp256
                ssh-ed25519
              ],

              'encryption_algorithms' => %w[
                aes128-ctr
                aes192-ctr
                aes256-ctr
                arcfour256
                arcfour128
                aes128-gcm@openssh.com
                aes256-gcm@openssh.com
                chacha20-poly1305@openssh.com
                aes128-cbc
                3des-cbc
                blowfish-cbc
                cast128-cbc
                aes192-cbc
                aes256-cbc
                arcfour
                rijndael-cbc@lysator.liu.se
              ],

              'mac_algorithms' => %w[
                hmac-md5-etm@openssh.com
                hmac-sha1-etm@openssh.com
                umac-64-etm@openssh.com
                umac-128-etm@openssh.com
                hmac-sha2-256-etm@openssh.com
                hmac-sha2-512-etm@openssh.com
                hmac-ripemd160-etm@openssh.com
                hmac-sha1-96-etm@openssh.com
                hmac-md5-96-etm@openssh.com
                hmac-md5
                hmac-sha1
                umac-64@openssh.com
                umac-128@openssh.com
                hmac-sha2-256
                hmac-sha2-512
                hmac-ripemd160
                hmac-ripemd160@openssh.com
                hmac-sha1-96
                hmac-md5-96
              ],

              'compression_algorithms' => %w[
                none
                zlib@openssh.com
              ]
            }
          )
        end
      end

      context "when the <script> contains unnamed <table> XML elements" do
        subject { @xml.hosts.first.ports.first.scripts['ssh-hostkey'] }

        it "must return an Array of Hashes" do
          expect(subject.data).to eq(
            [
              {
                'fingerprint' => 'ac00a01a82ffcc5599dc672b34976b75',
                'key' => 'QUFBQUIzTnphQzFrYzNNQUFBQ0JBT2U4bzU5dkZXWkdhQm1HUFZlSkJPYkVmaTFBUjh5RVVZQy9VZmtrdTNzS2hHRjd3TTJtMnVqSWVaREs1dnFlQzBTNUVOMnhZbzZGc2hDUDRGUVJZZVR4RDE3bk5PNFBod1c2NXFBakRSUlUwdUhGZlNBaDV3ayt2dDR5UXp0T0UrK3NUZDFHOU9CTHpBOEhPOTlxRG1DQXhiM3p3K0dRREVnUGp6Z3l6R1ozQUFBQUZRQ0JtRTF2Uk9QOElhUGtVbWhNNXhMRnRhL3hId0FBQUlFQTNFd1JmYWVPUExMN1RLRGdHWDY3TGJrZjlVdGRscENkQzRkb01qR2dzem5ZTXdXSDZhN0xqM3ZpNC9LbWVaWmRpeDZGTWRGcXErMnZyZlQxRFJxeDBSUzBYWWRHeG5rZ1MrMmczMzNXWUNyVWtEQ242UlBVV1IvMVRnR01QSENqN0xXQ2ExWndKd0xXUzJLWDI4OFBhMmdMT1d1aFptMlZZS1NReDZORURPSUFBQUNCQU54SWZwclNkQmRibzRFenJoNi9YNkhTdnJoanRaN01vdVN0V2FFNzE0QnlPNWJTMmNvTTlDeWFDd1l5ckU1cXpZaXlJZmIrMUJHM081blZkRHVOOTVzUS8wYkFkQktsa3FMRnZGcUZqVmJFVEYwcmkzdjk3dzZNcFVhd2ZGNzVvdURyUTR4ZGFVT0xMRVdUc282VkZKY002Smc5YkRsMEZBMHVMWlVTREVITA==',
                'type' => 'ssh-dss',
                'bits' => '1024'
              },

              {
                'fingerprint' => '203d2d44622ab05a9db5b30514c2a6b2',
                'key' => 'QUFBQUIzTnphQzF5YzJFQUFBQURBUUFCQUFBQkFRQzZhZm9vVFo5bVZVR0ZORWhrTW9SUjFCdHp1NjRYWHdFbGhDc0h3L3pWbEl4L0hYeWxOYmI5KzExZG0yVmdKUTIxcHhrV0RzK0w2K0ViWXlEbnZSVVJUck1UZ0hMMHhzZUIwRWtOcWV4czloWVpTaXF0TXg0anRHTnRIdnNNeFpuYnh2VlVrMmRhc1d2dEJrbjhKNUphZ1NieldUUW80aGpLTU9JMVNVbFh0aUt4QXMyRjh3aXEyRWRTdUt3L0tOazhHZklwMVRBKzhjY0dlQXRuc1ZwdFRKNEQvOE1oQVdzUk9rUXpPb3dRdm5CQnoyLzhlY0V2b01TY2FmK2tEZk5Rb3dLM2dFTnRTU09xWXc5SkxPemE2WUpCUEwvYVl1UVEwbko3NFJyNXZMNDRhTklsckdJOWpKYzJ4MGJWN0JlTkE1a1Z1WHNtaHlmV2Jia0I4eUdk',
                'type' => 'ssh-rsa',
                'bits' => '2048'
              },

              {
                'fingerprint' => '9602bb5e57541c4e452f564c4a24b257',
                'key' => 'QUFBQUUyVmpaSE5oTFhOb1lUSXRibWx6ZEhBeU5UWUFBQUFJYm1semRIQXlOVFlBQUFCQkJNRDQ2ZzY3eDZ5V05qalFKblhoaXovVHNrSHJxUTB1UGNPc3BGcklZVzM4MnVPR3ptV0RaQ0ZWOEZiRndReUg5MHUrajBRcjFTR05BeEJaTWhPUThwYz0=',
                'type' => 'ecdsa-sha2-nistp256',
                'bits' => '256'
              }
            ]
          )
        end
      end
    end
  end
end
