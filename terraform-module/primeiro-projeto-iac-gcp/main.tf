resource "google_compute_instance" "vm" {
    name = "my-instance"
    machine_type = "e2-micro"
    zone = "us-central1-a"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }
    network_interface {
        network = "default"
    }
}