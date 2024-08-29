_LUT = {
    "macosx": "darwin",
    "aarch64": "arm64",
    "linux": "linux",
    "windows": "windows",
    "amd64": "amd64",
    "i386": "386",  # Untested
    "arm": "arm",
    "ppc64": "ppc64le",  # Untested
    "freebsd": "freebsd",  # Untested
    "netbsd": "netbsd",  # Untested
    "openbsd": "openbsd",  # Untested
    "solaris": "solaris",
}

def java_prop_to_hashicorp(str):
    return _LUT[str]

def hashicorp_to_java_prop(str):
    return {v: k for k, v in _LUT.items()}.get(str, False)
