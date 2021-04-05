read -s -p password: TF_VAR_vsphere_password
export TF_VAR_vsphere_password=$TF_VAR_password
export PS1="(env) $PS1"
