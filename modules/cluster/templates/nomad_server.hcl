data_dir   = "/mnt/nomad"
datacenter = "${datacenter}"
region = "${region}"
bind_addr = "0.0.0.0"
advertise {
  http = "${advertise_addr}"
  rpc = "${advertise_addr}"
  serf = "${advertise_addr}"
}
server {
    enabled = true
    bootstrap_expect = ${instance_count}
}

telemetry {
  publish_allocation_metrics = true
  publish_node_metrics       = true
}
enable_syslog = true
log_level = "DEBUG"