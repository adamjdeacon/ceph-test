resource "google_compute_instance" "ceph-ods" {
  name                      = "ceph-ods-${count.index + 1}"
  machine_type              = "n1-standard-2"
  count                     = var.node_count
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
      nat_ip = google_compute_address.ods[count.index].address
    }
  }
    lifecycle {
    ignore_changes = [attached_disk]
  }
}

resource "google_compute_disk" "ods-disks" {
  name  = "ods-disk-${count.index + 1}"
  type  = "pd-standard"
  count = var.node_count
  size  = "100"
}

resource "google_compute_attached_disk" "ods" {
  disk     = google_compute_disk.ods-disks[count.index].id
  instance = google_compute_instance.ceph-ods[count.index].id
  count = var.node_count
}

resource "google_compute_address" "ods" {
  name = "ods-${count.index + 1}"
  count = var.node_count
}
