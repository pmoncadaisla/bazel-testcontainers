load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_JVM_EXTERNAL_TAG = "3.1"

RULES_JVM_EXTERNAL_SHA = "e246373de2353f3d34d35814947aa8b7d0dd1a58c2f7a6c41cfeaff3007c2d14"

http_archive(
    name = "rules_jvm_external",
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    sha256 = RULES_JVM_EXTERNAL_SHA,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)

load("@//:maven.bzl", "maven")
maven()

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "7d453450e1eb70e238eea6b31f4115607ec1200e91afea01c25f9804f37e39c8",
    strip_prefix = "rules_docker-0.10.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.10.0/rules_docker-v0.10.0.tar.gz"],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

http_archive(
    name = "remote_java_tools_linux",
    sha256 = "37acb8380b1dd6c31fd27a19bf3da821c9b02ee93c6163fce36f070a806516b5",
    urls = [
        "https://mirror.bazel.build/bazel_java_tools/releases/javac11/v6.0/java_tools_javac11_linux-v6.0.zip",
        "https://github.com/bazelbuild/java_tools/releases/download/javac11-v6.0/java_tools_javac11_linux-v6.0.zip",
    ],
)
http_archive(
    name = "remote_java_tools_windows",
    sha256 = "384e138ca58842ea563fb7efbe0cb9c5c381bd4de1f6a31f0256823325f81ccc",
    urls = [
        "https://mirror.bazel.build/bazel_java_tools/releases/javac11/v6.0/java_tools_javac11_windows-v6.0.zip",
        "https://github.com/bazelbuild/java_tools/releases/download/javac11-v6.0/java_tools_javac11_windows-v6.0.zip",
    ],
)
http_archive(
    name = "remote_java_tools_darwin",
    sha256 = "5a9f320c33424262e505151dd5c6903e36678a0f0bbdaae67bcf07f41d8c7cf3",
    urls = [
        "https://mirror.bazel.build/bazel_java_tools/releases/javac11/v6.0/java_tools_javac11_darwin-v6.0.zip",
        "https://github.com/bazelbuild/java_tools/releases/download/javac11-v6.0/java_tools_javac11_darwin-v6.0.zip",
    ],
)

load(
    "@io_bazel_rules_docker//java:image.bzl",
    _java_image_repos = "repositories",
)

_java_image_repos()

http_archive(
    name = "bazel_toolchains",
    sha256 = "e2126599d29f2028e6b267eba273dcc8e7f4a35ff323e9600cf42fb03875b7c6",
    strip_prefix = "bazel-toolchains-2.0.0",
    urls = [
        "https://github.com/bazelbuild/bazel-toolchains/releases/download/2.0.0/bazel-toolchains-2.0.0.tar.gz",
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-toolchains/archive/2.0.0.tar.gz",
    ],
)

load("@bazel_toolchains//rules/exec_properties:exec_properties.bzl", "rbe_exec_properties")

# rbe_exec_properties defines a local repository named "exec_properties"
# which defines constants such as "NETWORK_ON"
rbe_exec_properties(
  name = "exec_properties",
)

load("@bazel_toolchains//rules:rbe_repo.bzl", "rbe_autoconfig")
load("@exec_properties//:constants.bzl", "NETWORK_ON", "DOCKER_SIBLINGS_CONTAINERS")
load("@bazel_skylib//lib:dicts.bzl", "dicts")


# Creates a default toolchain config for RBE.
# Use this as is if you are using the rbe_ubuntu16_04 container,
# otherwise refer to RBE docs.
rbe_autoconfig(
    name = "rbe_default",
    java_home = "/usr/lib/jvm/11.29.3-ca-jdk11.0.2/reduced",
    use_legacy_platform_definition = False,
    exec_properties = dicts.add(DOCKER_SIBLINGS_CONTAINERS, NETWORK_ON),
    # use_checked_in_confs = "Force",
)

# rules_proto defines abstract rules for building Protocol Buffers.
http_archive(
    name = "rules_proto",
    sha256 = "57001a3b33ec690a175cdf0698243431ef27233017b9bed23f96d44b9c98242f",
    strip_prefix = "rules_proto-9cd4f8f1ede19d81c6d48910429fe96776e567b1",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/9cd4f8f1ede19d81c6d48910429fe96776e567b1.tar.gz",
        "https://github.com/bazelbuild/rules_proto/archive/9cd4f8f1ede19d81c6d48910429fe96776e567b1.tar.gz",
    ],
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()
