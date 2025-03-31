### Google Cloud CLI Setup with SSO

1. Install Google Cloud SDK on macOS using Homebrew:

```bash
brew install --cask google-cloud-sdk
```

2. Login using SSO:

```bash
gcloud auth login --update-adc
```

This will open your browser to authenticate using your organization's SSO.

3. Configure Application Default Credentials (ADC):

```bash
gcloud auth application-default login
```

4. Set your project:

```bash
gcloud config set project YOUR_PROJECT_ID
```

### Provider Configuration with ADC

Configure the Google Cloud provider to use Application Default Credentials:

```hcl
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}
```

### Authentication Methods

The recommended authentication methods in order of preference:

- Workload Identity Federation (for CI/CD)
- Application Default Credentials with SSO (for development)
- Service Account (for specific use cases)

Note: When using SSO, credentials are automatically rotated and you don't need to manage service account keys.

## References:

- [Installing Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [Google Cloud Authentication Methods](https://cloud.google.com/docs/authentication)
- [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation)
