resource "google_compute_instance" "ceph-osd" {
  name                      = "osd${count.index + 1}"
  machine_type              = "n1-standard-2"
  count                     = local.node_count
  allow_stopping_for_update = true
  #tags                      = ["http-server", "https-server"]
  labels = {
    terraform = ""
    patch     = "true"
  }
  service_account {
    email = local.compute_service_account
    # scopes from https://cloud.google.com/sdk/gcloud/reference/alpha/compute/instances/set-scopes#--scopes
    scopes = ["logging-write", "monitoring-write", "pubsub", "service-control", "service-management", "storage-ro", "https://www.googleapis.com/auth/trace.append"]
  }
  boot_disk {
    initialize_params {
      image = local.default_image
      size  = 20
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.osd[count.index].address
    }
  }
    lifecycle {
    ignore_changes = [attached_disk]
  }
}

resource "google_compute_disk" "osd-disks" {
  name  = "osd-disk-${count.index + 1}"
  type  = "pd-standard"
  count = local.node_count
  size  = "100"
}

resource "google_compute_attached_disk" "osd" {
  disk     = google_compute_disk.osd-disks[count.index].id
  instance = google_compute_instance.ceph-osd[count.index].id
  count = local.node_count
}

resource "google_compute_address" "osd" {
  name = "osd-${count.index + 1}"
  count = local.node_count
}
