data_dir   = "/mnt/nomad"
datacenter = "${datacenter}"
region = "${region}"
bind_addr = "0.0.0.0"
advertise {
  http = "${advertise_addr}"
  rpc = "${advertise_addr}"
  serf = "${advertise_addr}"
}
client {
  enabled = true
}