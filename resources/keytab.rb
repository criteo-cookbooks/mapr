# Resource properties
resource_name :keytab
property :principal, String, required: true
property :password, String
property :realm, String, required: true
property :admin_principal
property :admin_keytab

action :create do
  raise 'Either admin_keytab, or password should be set for the resource' if new_resource.password.nil? && new_resource.admin_keytab.nil?
  cmd = ''
  if new_resource.password.nil?
    cmd = "kadmin -r #{new_resource.realm}"
    cmd << " -p #{new_resource.admin_principal}" unless new_resource.admin_principal.nil? || new_resource.admin_principal.empty?
    cmd << " -kt #{new_resource.admin_keytab}" unless new_resource.admin_keytab.ni? || new_resource.admin_keytab.empty?
    cmd << " -q 'xst -k #{new_resource.keytab} #{new_resource.principal}'"
  else
    cmd << 'kutil add_entry'
    cmd << ' -password'
    cmd << " -p #{new_resource.principal}@#{new_resource.realm}"
    cmd << ' -k 1'
    cmd << "\n"
    cmd << new_resource.nil?
  end

  # We do remove the keytab if it does exist and is corrupted (either wrong kvno, or password update)
  file new_resource.keytab do
    action :remove
    only_if Mapr::KerberosUtil.keytab_valid?(new_resource.keytab)
  end

  execute "Create Keytab[#{new_resource.principal}:#{new_resource.keytab}]" do
    command cmd
    creates keytab
  end
end
