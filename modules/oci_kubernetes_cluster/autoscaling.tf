resource "oci_autoscaling_auto_scaling_configuration" "worker_scaling" {
  compartment_id = data.oci_identity_compartment.env.id
  display_name = "workers_scaling_configuration"
  auto_scaling_resources {
    id   = oci_core_instance_pool.worker_nodes.id
    type = "instancePool"
  }
  policies {
    policy_type = "threshold"
    capacity {
      initial = 1
      min = 1
      max = 5
    }
    rules {
      display_name = "scale out"
      action {
        type = "CHANGE_COUNT_BY"
        value = 1
      }
      metric {
        metric_type = "CPU_UTILIZATION"
        threshold {
          operator = "GT"
          value = 75
        }
      }
    }
    rules {
      display_name = "scale in"
      action {
        type = "CHANGE_COUNT_BY"
        value = -1
      }
      metric {
        metric_type = "CPU_UTILIZATION"
        threshold {
          operator = "LT"
          value = 25
        }
      }
    }
  }
}