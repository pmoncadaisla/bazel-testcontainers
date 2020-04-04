# Bazel Testcontainers

This repository is just a proof of concept of a Java application what uses [Testcontainers](https://www.testcontainers.org/) for testing.

In this PoC we will:
1. Test if we can build and test a Bazel project locally using Testcontainers
    - :white_check_mark: Build
    - :white_check_mark: Test
2. Test if we can build and test a Bazel project remotely using Testcontainers and Bazel RBE ([Remote Build Execution](https://docs.bazel.build/versions/master/remote-execution.html)) in Google Cloud RBE.
    - :white_check_mark: Build
    - :white_check_mark: Test

This repository takes as an example the `redis-backed-cache` from the offical [java testcontainers examples](https://github.com/testcontainers/testcontainers-java/tree/master/examples/redis-backed-cache).

## What is Bazel?
Bazel is a build system, just like `Make` or `Gradle`.

Some of it features:
- Suitable for almost every programming language.
- Suitable for large monorepos
- Scalable
- Speeds up building and testing

Some of Bazel's features include Remote Build Execution. With RBE we can spread our builds and tests within a large and remote build farm. This way we can speed up even more our builds and tests.

Learn more about Bazel at https://bazel.build/ and chech [remote execution overview](https://docs.bazel.build/versions/master/remote-execution.html).

## What are Testcontainers?

With Testcontainers you can manage programatically environment dependencies needed for running your integration or acceptance tests.
For example, you need a running database, a Kafka Cluster or a Browser to run UI tests.
Testcontainers is available for multiple languages (Java, Go, Python...).
Your only requisite will be to have a running Docker API endpoint (Unix Socket or TCP).

In this repository we will see how can we combine `Bazel` and `Testcontainers`.



## Executing Bazel
### 1. Locally

#### Build

To build locally using Bazel:
```
bazel build //...
```

Expected output:
```
INFO: Analyzed 3 targets (31 packages loaded, 702 targets configured).
INFO: Found 3 targets...
INFO: Deleting stale sandbox base /private/var/tmp/_bazel_pablo.moncada/f30eaa7669672642f9999e4ad8e660c0/sandbox
INFO: Elapsed time: 5.751s, Critical Path: 0.38s
INFO: 0 processes.
INFO: Build completed successfully, 1 total action
```

#### Test

To test locally using Bazel:
```
bazel test //...
```

Expected output:
```
INFO: Analyzed 3 targets (0 packages loaded, 0 targets configured).
INFO: Found 2 targets and 1 test target...
INFO: Elapsed time: 0.273s, Critical Path: 0.02s
INFO: 0 processes.
INFO: Build completed successfully, 1 total action
//src/test/java:RedisBackedCacheTest                             PASSED in 19.3s

Executed 0 out of 1 test: 1 test passes.
INFO: Build completed successfully, 1 total action
```

### 2. Remotely

To execute a build remotely using Google RBE you will need to have access to the private alpha.
You can request access by filling [this form.](https://docs.google.com/forms/d/e/1FAIpQLScBai-iQ2tn7RcGcsz3Twjr4yDOeHowrb6-3v5qlgS69GcxbA/viewform)

You can also use self-hosted solutions:
- [Buildbarn](https://github.com/buildbarn)
- [Buildfarm](https://github.com/bazelbuild/bazel-buildfarm)


#### Build

To build remotely using Bazel:
```
bazel build //... --config=remote --remote_instance_name=projects/$GCP_PROJECT_ID/instances/$RBE_INSTANCE
```

Expected output:
```
INFO: Analyzed 13 targets (1 packages loaded, 126 targets configured).
INFO: Found 13 targets...
INFO: Elapsed time: 67.431s, Critical Path: 66.28s
INFO: 66 processes: 1 remote cache hit, 65 remote.
INFO: Build completed successfully, 117 total actions
```

#### Test


To test remotely using Bazel:
```
bazel test //... --config=remote --remote_instance_name=projects/$GCP_PROJECT_ID/instances/$RBE_INSTANCE
```

Expected output:
```
INFO: Analyzed 3 targets (0 packages loaded, 0 targets configured).
INFO: Found 2 targets and 1 test target...
INFO: Elapsed time: 1.237s, Critical Path: 0.01s
INFO: 0 processes.
INFO: Build completed successfully, 1 total action
//src/test/java:RedisBackedCacheTest                            (cached) PASSED in 28.3s

Executed 0 out of 1 test: 1 test passes.
INFO: Build completed successfully, 1 total action

```