# Java: CRM, Catalogue, Watcher ------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------

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
    sha256 = "4e55e44bdf352c61204956c08e7afaa7ee156caffc31c69dd944ea88bb799b00",
    strip_prefix = "bazel-toolchains-6a976945fd2017ffa6b5a0899a9caf004bb58b0f",
    urls = [
        "https://github.com/bazelbuild/bazel-toolchains/archive/6a976945fd2017ffa6b5a0899a9caf004bb58b0f.tar.gz",
    ],
)

load(
    "@bazel_toolchains//repositories:repositories.bzl",
    bazel_toolchains_repositories = "repositories",
)

bazel_toolchains_repositories()