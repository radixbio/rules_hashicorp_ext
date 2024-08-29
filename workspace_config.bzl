load("lut.bzl", "hashicorp_to_java_prop")

_HASHICORP_URL = "https://releases.hashicorp.com/{product}/{version}/{product}_{version}_{os}_{arch}.zip"
_HASHIHASH_URL = "https://releases.hashicorp.com/{product}/{version}/{product}_{version}_SHA256SUMS"

def _shas(repository_ctx, hashicorp_product, version):
    repository_ctx.download(
        url = _HASHIHASH_URL.format(product = hashicorp_product, version = version),
        output = "{product}_{version}_shas.txt".format(product = hashicorp_product, version = version),
    )

    shas = repository_ctx.read(
        "{product}_{version}_shas.txt".format(product = hashicorp_product, version = version),
    )

    fname_lut = {}
    for line in shas.split("\n"):
        if len(line.split(" ")) == 3:
            fname_lut[line.split(" ")[2]] = line.split(" ")[0]

    return fname_lut

def _unravel_fname(fn_sha_dict_lst, valid_os, valid_arch):
    shas = {}
    for elt in fn_sha_dict_lst:
        for line, sha in elt.items():
            info = line.split("_")
            product = info[0]
            version = info[1]
            os = info[2]
            if os != "manifest.json":
                os = info[2]

                arch = info[3][:-4]
                if any([x for x in valid_os[product] if x == hashicorp_to_java_prop(os)]) and any([x for x in valid_arch[product] if x == hashicorp_to_java_prop(arch)]):
                    export_name = ""
                    if os == "windows":
                        export_name = product + ".exe"
                    else:
                        export_name = product

                    shas.setdefault(product, {}).setdefault(version, {}).setdefault(os, {}).setdefault(
                        arch,
                        (
                            sha,
                            _HASHICORP_URL.format(
                                product = product,
                                version = version,
                                os = os,
                                arch = arch,
                            ),
                            export_name,
                        ),
                    )
    return shas

def _hashicorp_configure_impl(repository_ctx):
    products = repository_ctx.attr.products.keys()
    versions = repository_ctx.attr.products.values()

    shas = [_shas(repository_ctx, p, v) for p, v in zip(products, versions) if v != ""]
    lut = _unravel_fname(shas, repository_ctx.attr.os, repository_ctx.attr.arch)

    config_file_content = "LUT={lut}".format(lut = lut)

    repository_ctx.file("config.bzl", config_file_content)
    repository_ctx.file("BUILD")

hashicorp_configure = repository_rule(
    implementation = _hashicorp_configure_impl,
    attrs = {
        "products": attr.string_dict(),
        "os": attr.string_list_dict(),
        "arch": attr.string_list_dict(),
    },
)
