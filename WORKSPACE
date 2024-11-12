workspace(
    name = "com_github_rules_hashicorp"
)

load("//:workspace_config.bzl", "hashicorp_configure")

hashicorp_configure(
    name = "hashicorp",
    arch = {
        "nomad": [
            "amd64",
            "aarch64",
        ],
        "terraform": [
            "amd64",
            "aarch64",
        ],
        "consul": [
            "amd64",
            "aarch64",
        ],
        "consul-template": [
            "amd64",
            "aarch64",
        ],
        "vault": [
            "amd64",
            "aarch64",
        ],
        "terraform-provider-consul": [
            "amd64",
            "aarch64",
        ],
        "terraform-provider-nomad": [
            "amd64",
            "aarch64",
        ],
        "terraform-provider-vault": [
            "amd64",
            "aarch64",
        ],
    },
    os = {
        "nomad": [
            "macosx",
            "linux",
            "windows",
        ],
        "terraform": [
            "macosx",
            "linux",
            "windows",
        ],
        "consul": [
            "macosx",
            "linux",
            "windows",
        ],
        "consul-template": [
            "macosx",
            "linux",
            "windows",
        ],
        "vault": [
            "macosx",
            "linux",
            "windows",
        ],
        "terraform-provider-consul": [
            "macosx",
            "linux",
            "windows",
        ],
        "terraform-provider-nomad": [
            "macosx",
            "linux",
            "windows",
        ],
        "terraform-provider-vault": [
            "macosx",
            "linux",
            "windows",
        ],
    },
    products = {
        "nomad": "1.3.3",
        "terraform": "1.1.9",
        "consul": "1.10.1",
        "consul-template": "0.29.0",
        "vault": "1.10.0",
        "terraform-provider-nomad": "1.4.16",
        "terraform-provider-consul": "2.15.1",
        "terraform-provider-vault": "3.5.0",
    },
)

load("//:workspace_dependencies.bzl", "hashicorp_dependencies")

hashicorp_dependencies()
