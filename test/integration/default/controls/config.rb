# frozen_string_literal: true

attributes = {
  'fstype' => 'cifs',
  'server' => 'filer.example.net',
  'path' => '%(USER)/',
  'options' => %w[cifsacl
                  cruid=%(USERUID)
                  dir_mode=0700
                  domain=example.net
                  file_mode=0600
                  sec=krb5
                  uid=%(USERUID)
                  username=%(USER)].join(',')
}.freeze

control 'pam-mount/config/file' do
  title 'verify pam_mount.conf.xml options and volumes'

  describe xml('/etc/security/pam_mount.conf.xml') do
    its('pam_mount/debug/@enable') { should eq ['1'] }
    attributes.each do |attribute, value|
      its("pam_mount/volume[@mountpoint='~']/@#{attribute}") { should eq [value] }
    end
  end
end
