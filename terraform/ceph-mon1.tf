resource "google_compute_instance" "ceph-mon1" {
  name                      = "ceph-mon1"
  machine_type              = "n1-standard-2"
  allow_stopping_for_update = true
  #tags                      = ["http-server", "https-server"]
  labels = {
    terraform = ""
    patch     = "true"
  }
  service_account {
    email = var.compute_service_account
    # scopes from https://cloud.google.com/sdk/gcloud/reference/alpha/compute/instances/set-scopes#--scopes
    scopes = ["logging-write", "monitoring-write", "pubsub", "service-control", "service-management", "storage-ro", "https://www.googleapis.com/auth/trace.append"]
  }
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
      size  = 20
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.ceph-mon1.address
    }
  }
}

resource "google_compute_address" "ceph-mon1" {
  name = "ceph-mon1"
}
