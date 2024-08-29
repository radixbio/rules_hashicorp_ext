load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@hashicorp//:config.bzl", "LUT")
load("lut.bzl", "hashicorp_to_java_prop")

def hashicorp_dependencies():
    for product, further1 in LUT.items():
        for version, further2 in further1.items():
            for os, further3 in further2.items():
                for arch, (sha, url, fn) in further3.items():
                    if product.find("terraform-provider") != -1:
                        maybe(
                            http_file,
                            name = "{product}_{os}_{arch}".format(
                                product = product,
                                os = hashicorp_to_java_prop(os),
                                arch = hashicorp_to_java_prop(arch),
                            ),
                            urls = [url],
                            sha256 = sha,
                            downloaded_file_path = "{prov}/{product}_{version}_{os}_{arch}.zip".format(
                                prov = product[len("terraform-provider-"):],
                                product = product,
                                version = version,
                                os = hashicorp_to_java_prop(os),
                                arch = hashicorp_to_java_prop(arch),
                            ),
                        )
                    else:
                        bfc = 'exports_files(["' + fn + '"])'
                        maybe(
                            http_archive,
                            name = "{product}_{os}_{arch}".format(
                                product = product,
                                os = hashicorp_to_java_prop(os),
                                arch = hashicorp_to_java_prop(arch),
                            ),
                            url = url,
                            sha256 = sha,
                            build_file_content = bfc,
                        )
