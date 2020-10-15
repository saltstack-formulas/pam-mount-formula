# frozen_string_literal: true

package_name =
  case system.platform[:family]
  when 'debian'
    'libpam-mount'
  else
    'pam_mount'
  end

dependencies = %w[
  cifs-utils
  keyutils
]

control 'pam-mount/package/installed' do
  title 'required packages and dependencies should be installed'

  describe package(package_name) do
    it { should be_installed }
  end

  dependencies.each do |name|
    describe package(name) do
      it { should be_installed }
    end
  end
end
