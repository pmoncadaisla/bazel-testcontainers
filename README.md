# Bazel Testcontainers

This repository is just a proof of concept of a Java application what uses [Testcontainers](https://www.testcontainers.org/) for testing.

In this PoC we will:
1. Test if we can build a Bazel project locally using Testcontainers
2.  Test if we can build a Bazel project remotely using Testcontainers and Bazel RBE ([Remote Build Execution](https://docs.bazel.build/versions/master/remote-execution.html)) in Google Cloud RBE.


## 1. Locally

### Build

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

### Test

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

## 2. Remotely

:warning: **Pending test**

### Build

To build remotely using Bazel:
```
bazel build //... --config=remote
```

Expected output:
```

```

### Test

To test remotely using Bazel:
```
bazel test //... --config=remote
```

Expected output:
```

```