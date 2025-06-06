target "docker-metadata-action" {}

variable "VERSION" {
  // renovate: datasource=github-releases depName=lucanori/web2md versioning=loose
  default = "v1.1.4"
}

variable "SOURCE" {
  default = "https://github.com/lucanori/web2md"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}