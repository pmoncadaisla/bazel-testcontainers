# Bazel Testcontainers

This repository is just a proof of concept of a Java application what uses [Testcontainers](https://www.testcontainers.org/) for testing.

In this PoC we will:
1. Test if we can build and test a Bazel project locally using Testcontainers
    - :white_check_mark: Build
    - :white_check_mark: Test
2. Test if we can build and test a Bazel project remotely using Testcontainers and Bazel RBE ([Remote Build Execution](https://docs.bazel.build/versions/master/remote-execution.html)) in Google Cloud RBE.
    - :white_check_mark: Build
    - :x: Test


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

To execute a build remotely using Google RBE you will need to have access to the private alpha.
You can request access by filling [this form.](https://docs.google.com/forms/d/e/1FAIpQLScBai-iQ2tn7RcGcsz3Twjr4yDOeHowrb6-3v5qlgS69GcxbA/viewform)


### Build

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

### Test

:x: This does not work in RBE

Why doesn't this work in Google Remote Build Execution?
Testcontainers expect to have an underlying Docker engine exposed via unix socket or TCP.
Remote builds are executed in a Docker container somewhere in Google's infrastructure. Even if they are run in a Docker environment the Docker Engine is not exposed and we can't access it from within the build.

We will get an expected error like this:
```
Caused by: java.lang.IllegalStateException: Could not find a valid Docker environment. Please see logs and check configuration
```

Does this mean we cannot do remote builds with testscontainers? No, this means we can't do it with Google's RBE, but we could use our own self-hosted service:
- [Buildbarn](https://github.com/buildbarn)
- [Buildfarm](https://github.com/bazelbuild/bazel-buildfarm)
- [BuildGrid](https://gitlab.com/BuildGrid/buildgrid)
- [Scoot](https://github.com/twitter/scoot)

If you even want to give it a try yourself, you can:

To test remotely using Bazel:
```
bazel test //... --config=remote --remote_instance_name=projects/$GCP_PROJECT_ID/instances/$RBE_INSTANCE
```

Expected output:
```
INFO: Analyzed 3 targets (0 packages loaded, 0 targets configured).
INFO: Found 2 targets and 1 test target...
JUnit4 Test Runner
.15:45:09.838 [main] DEBUG org.testcontainers.utility.TestcontainersConfiguration - Testcontainers configuration overrides will be loaded from file:/home/nobody/.testcontainers.properties
15:45:11.159 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:11.498 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@52fa46fe
15:45:12.363 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:12.364 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@72db9396
15:45:12.868 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:12.869 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@7ca75892
15:45:13.372 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:13.372 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@517ed4ae
15:45:13.876 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:13.877 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@3ff19385
15:45:14.383 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:14.383 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@1198e0ce
15:45:14.885 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:14.885 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@57bd59a7
15:45:15.391 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:15.392 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@15d7e251
15:45:15.898 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:15.899 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@289ae12d
15:45:16.404 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:16.404 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@51c0bb88
15:45:16.906 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:16.906 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@6d409948
15:45:17.409 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:17.409 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@47af3bdb
15:45:17.911 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:17.912 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@3843298a
15:45:18.417 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:18.418 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@6c0bc9f1
15:45:18.923 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:18.923 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@5e897e1
15:45:19.427 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:19.428 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@28ff7202
15:45:19.931 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:19.932 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@69e9bf63
15:45:20.437 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:20.438 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@6a661b1f
15:45:20.940 [ducttape-0] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - Pinging docker daemon...
15:45:20.940 [ducttape-0] DEBUG com.github.dockerjava.core.command.AbstrDockerCmd - Cmd: org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1@3b1954dc
15:45:21.164 [main] ERROR org.testcontainers.dockerclient.EnvironmentAndSystemPropertyClientProviderStrategy - ping failed with configuration Environment variables, system properties and defaults. Resolved dockerHost=unix:///var/run/docker.sock due to org.rnorth.ducttape.TimeoutException: Timeout waiting for result with exception
org.rnorth.ducttape.TimeoutException: Timeout waiting for result with exception
	at org.rnorth.ducttape.unreliables.Unreliables.retryUntilSuccess(Unreliables.java:54)
	at org.testcontainers.dockerclient.DockerClientProviderStrategy.ping(DockerClientProviderStrategy.java:183)
	at org.testcontainers.dockerclient.EnvironmentAndSystemPropertyClientProviderStrategy.test(EnvironmentAndSystemPropertyClientProviderStrategy.java:41)
	at org.testcontainers.dockerclient.DockerClientProviderStrategy.lambda$getFirstValidStrategy$2(DockerClientProviderStrategy.java:118)
	at java.base/java.util.stream.ReferencePipeline$7$1.accept(Unknown Source)
	at java.base/java.util.stream.StreamSpliterators$WrappingSpliterator.tryAdvance(Unknown Source)
	at java.base/java.util.stream.Streams$ConcatSpliterator.tryAdvance(Unknown Source)
	at java.base/java.util.stream.ReferencePipeline.forEachWithCancel(Unknown Source)
	at java.base/java.util.stream.AbstractPipeline.copyIntoWithCancel(Unknown Source)
	at java.base/java.util.stream.AbstractPipeline.copyInto(Unknown Source)
	at java.base/java.util.stream.AbstractPipeline.wrapAndCopyInto(Unknown Source)
	at java.base/java.util.stream.FindOps$FindOp.evaluateSequential(Unknown Source)
	at java.base/java.util.stream.AbstractPipeline.evaluate(Unknown Source)
	at java.base/java.util.stream.ReferencePipeline.findAny(Unknown Source)
	at org.testcontainers.dockerclient.DockerClientProviderStrategy.getFirstValidStrategy(DockerClientProviderStrategy.java:154)
	at org.testcontainers.DockerClientFactory.getOrInitializeStrategy(DockerClientFactory.java:113)
	at org.testcontainers.DockerClientFactory.client(DockerClientFactory.java:134)
	at org.testcontainers.LazyDockerClient.getDockerClient(LazyDockerClient.java:14)
	at org.testcontainers.LazyDockerClient.listImagesCmd(LazyDockerClient.java:12)
	at org.testcontainers.images.LocalImagesCache.maybeInitCache(LocalImagesCache.java:68)
	at org.testcontainers.images.LocalImagesCache.get(LocalImagesCache.java:32)
	at org.testcontainers.images.AbstractImagePullPolicy.shouldPull(AbstractImagePullPolicy.java:18)
	at org.testcontainers.images.RemoteDockerImage.resolve(RemoteDockerImage.java:62)
	at org.testcontainers.images.RemoteDockerImage.resolve(RemoteDockerImage.java:25)
	at org.testcontainers.utility.LazyFuture.getResolvedValue(LazyFuture.java:20)
	at org.testcontainers.utility.LazyFuture.get(LazyFuture.java:27)
	at org.testcontainers.containers.GenericContainer.getDockerImageName(GenericContainer.java:1263)
	at org.testcontainers.containers.GenericContainer.logger(GenericContainer.java:600)
	at org.testcontainers.containers.GenericContainer.doStart(GenericContainer.java:311)
	at org.testcontainers.containers.GenericContainer.start(GenericContainer.java:302)
	at org.testcontainers.containers.GenericContainer.starting(GenericContainer.java:1008)
	at org.testcontainers.containers.FailureDetectingExternalResource$1.evaluate(FailureDetectingExternalResource.java:29)
	at org.junit.runners.ParentRunner$3.evaluate(ParentRunner.java:306)
	at org.junit.runners.BlockJUnit4ClassRunner$1.evaluate(BlockJUnit4ClassRunner.java:100)
	at org.junit.runners.ParentRunner.runLeaf(ParentRunner.java:366)
	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:103)
	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:63)
	at org.junit.runners.ParentRunner$4.run(ParentRunner.java:331)
	at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:79)
	at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:329)
	at org.junit.runners.ParentRunner.access$100(ParentRunner.java:66)
	at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:293)
	at org.junit.runners.ParentRunner$3.evaluate(ParentRunner.java:306)
	at org.junit.runners.ParentRunner.run(ParentRunner.java:413)
	at com.google.testing.junit.runner.internal.junit4.CancellableRequestFactory$CancellableRunner.run(CancellableRequestFactory.java:89)
	at org.junit.runner.JUnitCore.run(JUnitCore.java:137)
	at org.junit.runner.JUnitCore.run(JUnitCore.java:115)
	at com.google.testing.junit.runner.junit4.JUnit4Runner.run(JUnit4Runner.java:112)
	at com.google.testing.junit.runner.BazelTestRunner.runTestsInSuite(BazelTestRunner.java:153)
	at com.google.testing.junit.runner.BazelTestRunner.main(BazelTestRunner.java:84)
Caused by: java.io.IOException: com.sun.jna.LastErrorException: [2] No such file or directory
	at org.testcontainers.shaded.org.scalasbt.ipcsocket.UnixDomainSocket.<init>(UnixDomainSocket.java:62)
	at org.testcontainers.dockerclient.transport.okhttp.UnixSocketFactory$1.<init>(UnixSocketFactory.java:27)
	at org.testcontainers.dockerclient.transport.okhttp.UnixSocketFactory.createSocket(UnixSocketFactory.java:27)
	at org.testcontainers.shaded.okhttp3.internal.connection.RealConnection.connectSocket(RealConnection.java:257)
	at org.testcontainers.shaded.okhttp3.internal.connection.RealConnection.connect(RealConnection.java:183)
	at org.testcontainers.shaded.okhttp3.internal.connection.ExchangeFinder.findConnection(ExchangeFinder.java:224)
	at org.testcontainers.shaded.okhttp3.internal.connection.ExchangeFinder.findHealthyConnection(ExchangeFinder.java:108)
	at org.testcontainers.shaded.okhttp3.internal.connection.ExchangeFinder.find(ExchangeFinder.java:88)
	at org.testcontainers.shaded.okhttp3.internal.connection.Transmitter.newExchange(Transmitter.java:169)
	at org.testcontainers.shaded.okhttp3.internal.connection.ConnectInterceptor.intercept(ConnectInterceptor.java:41)
	at org.testcontainers.shaded.okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.java:142)
	at org.testcontainers.shaded.okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.java:117)
	at org.testcontainers.shaded.okhttp3.internal.cache.CacheInterceptor.intercept(CacheInterceptor.java:94)
	at org.testcontainers.shaded.okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.java:142)
	at org.testcontainers.shaded.okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.java:117)
	at org.testcontainers.shaded.okhttp3.internal.http.BridgeInterceptor.intercept(BridgeInterceptor.java:93)
	at org.testcontainers.shaded.okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.java:142)
	at org.testcontainers.shaded.okhttp3.internal.http.RetryAndFollowUpInterceptor.intercept(RetryAndFollowUpInterceptor.java:88)
	at org.testcontainers.shaded.okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.java:142)
	at org.testcontainers.shaded.okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.java:117)
	at org.testcontainers.shaded.okhttp3.RealCall.getResponseWithInterceptorChain(RealCall.java:229)
	at org.testcontainers.shaded.okhttp3.RealCall.execute(RealCall.java:81)
	at org.testcontainers.dockerclient.transport.okhttp.OkHttpInvocationBuilder.execute(OkHttpInvocationBuilder.java:270)
	at org.testcontainers.dockerclient.transport.okhttp.OkHttpInvocationBuilder.execute(OkHttpInvocationBuilder.java:265)
	at org.testcontainers.dockerclient.transport.okhttp.OkHttpInvocationBuilder.get(OkHttpInvocationBuilder.java:231)
	at org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1.execute(OkHttpDockerCmdExecFactory.java:124)
	at org.testcontainers.dockerclient.transport.okhttp.OkHttpDockerCmdExecFactory$1.execute(OkHttpDockerCmdExecFactory.java:117)
	at com.github.dockerjava.core.exec.AbstrSyncDockerCmdExec.exec(AbstrSyncDockerCmdExec.java:21)
	at com.github.dockerjava.core.command.AbstrDockerCmd.exec(AbstrDockerCmd.java:35)
	at org.testcontainers.dockerclient.DockerClientProviderStrategy.lambda$null$4(DockerClientProviderStrategy.java:186)
	at org.rnorth.ducttape.ratelimits.RateLimiter.getWhenReady(RateLimiter.java:51)
	at org.testcontainers.dockerclient.DockerClientProviderStrategy.lambda$ping$5(DockerClientProviderStrategy.java:184)
	at org.rnorth.ducttape.unreliables.Unreliables.lambda$retryUntilSuccess$0(Unreliables.java:43)
	at java.base/java.util.concurrent.FutureTask.run(Unknown Source)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
	at java.base/java.lang.Thread.run(Unknown Source)
Caused by: com.sun.jna.LastErrorException: [2] No such file or directory
	at org.testcontainers.shaded.org.scalasbt.ipcsocket.UnixDomainSocketLibrary.connect(Native Method)
	at org.testcontainers.shaded.org.scalasbt.ipcsocket.UnixDomainSocket.<init>(UnixDomainSocket.java:57)
	... 36 common frames omitted
15:45:21.167 [main] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - EnvironmentAndSystemPropertyClientProviderStrategy: failed with exception InvalidConfigurationException (ping failed)
15:45:21.169 [main] DEBUG org.testcontainers.dockerclient.DockerClientProviderStrategy - UnixSocketClientProviderStrategy: failed with exception InvalidConfigurationException (ping failed). Root cause NoSuchFileException (/var/run/docker.sock)
15:45:21.171 [main] ERROR org.testcontainers.dockerclient.DockerClientProviderStrategy - Could not find a valid Docker environment. Please check configuration. Attempted configurations were:
15:45:21.171 [main] ERROR org.testcontainers.dockerclient.DockerClientProviderStrategy -     EnvironmentAndSystemPropertyClientProviderStrategy: failed with exception InvalidConfigurationException (ping failed)
15:45:21.172 [main] ERROR org.testcontainers.dockerclient.DockerClientProviderStrategy -     UnixSocketClientProviderStrategy: failed with exception InvalidConfigurationException (ping failed). Root cause NoSuchFileException (/var/run/docker.sock)
15:45:21.173 [main] ERROR org.testcontainers.dockerclient.DockerClientProviderStrategy - As no valid configuration was found, execution cannot continue
E.15:45:21.181 [main] DEBUG 🐳 [redis:3.0.6] - redis:3.0.6 is not in image name cache, updating...
E
Time: 11.898
There were 2 failures:
1) testNotFindingAValueThatWasNotInserted(RedisBackedCacheTest)
org.testcontainers.containers.ContainerLaunchException: Container startup failed
	at org.testcontainers.containers.GenericContainer.doStart(GenericContainer.java:322)
	at org.testcontainers.containers.GenericContainer.start(GenericContainer.java:302)
	at org.testcontainers.containers.GenericContainer.starting(GenericContainer.java:1008)
	at org.testcontainers.containers.FailureDetectingExternalResource$1.evaluate(FailureDetectingExternalResource.java:29)
	at org.junit.runners.ParentRunner$3.evaluate(ParentRunner.java:306)
	at org.junit.runners.BlockJUnit4ClassRunner$1.evaluate(BlockJUnit4ClassRunner.java:100)
	at org.junit.runners.ParentRunner.runLeaf(ParentRunner.java:366)
	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:103)
	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:63)
	at org.junit.runners.ParentRunner$4.run(ParentRunner.java:331)
	at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:79)
	at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:329)
	at org.junit.runners.ParentRunner.access$100(ParentRunner.java:66)
	at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:293)
	at org.junit.runners.ParentRunner$3.evaluate(ParentRunner.java:306)
	at org.junit.runners.ParentRunner.run(ParentRunner.java:413)
	at com.google.testing.junit.runner.internal.junit4.CancellableRequestFactory$CancellableRunner.run(CancellableRequestFactory.java:89)
	at org.junit.runner.JUnitCore.run(JUnitCore.java:137)
	at org.junit.runner.JUnitCore.run(JUnitCore.java:115)
	at com.google.testing.junit.runner.junit4.JUnit4Runner.run(JUnit4Runner.java:112)
	at com.google.testing.junit.runner.BazelTestRunner.runTestsInSuite(BazelTestRunner.java:153)
	at com.google.testing.junit.runner.BazelTestRunner.main(BazelTestRunner.java:84)
Caused by: org.testcontainers.containers.ContainerFetchException: Can't get Docker image: RemoteDockerImage(imageNameFuture=java.util.concurrent.CompletableFuture@2f666ebb[Completed normally], imagePullPolicy=DefaultPullPolicy(), dockerClient=LazyDockerClient.INSTANCE)
	at org.testcontainers.containers.GenericContainer.getDockerImageName(GenericContainer.java:1265)
	at org.testcontainers.containers.GenericContainer.logger(GenericContainer.java:600)
	at org.testcontainers.containers.GenericContainer.doStart(GenericContainer.java:311)
	... 21 more
Caused by: java.lang.IllegalStateException: Could not find a valid Docker environment. Please see logs and check configuration
	at org.testcontainers.dockerclient.DockerClientProviderStrategy.lambda$getFirstValidStrategy$3(DockerClientProviderStrategy.java:163)
	at java.base/java.util.Optional.orElseThrow(Unknown Source)
	at org.testcontainers.dockerclient.DockerClientProviderStrategy.getFirstValidStrategy(DockerClientProviderStrategy.java:155)
	at org.testcontainers.DockerClientFactory.getOrInitializeStrategy(DockerClientFactory.java:113)
	at org.testcontainers.DockerClientFactory.client(DockerClientFactory.java:134)
	at org.testcontainers.LazyDockerClient.getDockerClient(LazyDockerClient.java:14)
	at org.testcontainers.LazyDockerClient.listImagesCmd(LazyDockerClient.java:12)
	at org.testcontainers.images.LocalImagesCache.maybeInitCache(LocalImagesCache.java:68)
	at org.testcontainers.images.LocalImagesCache.get(LocalImagesCache.java:32)
	at org.testcontainers.images.AbstractImagePullPolicy.shouldPull(AbstractImagePullPolicy.java:18)
	at org.testcontainers.images.RemoteDockerImage.resolve(RemoteDockerImage.java:62)
	at org.testcontainers.images.RemoteDockerImage.resolve(RemoteDockerImage.java:25)
	at org.testcontainers.utility.LazyFuture.getResolvedValue(LazyFuture.java:20)
	at org.testcontainers.utility.LazyFuture.get(LazyFuture.java:27)
	at org.testcontainers.containers.GenericContainer.getDockerImageName(GenericContainer.java:1263)
	... 23 more
2) testFindingAnInsertedValue(RedisBackedCacheTest)
org.testcontainers.containers.ContainerLaunchException: Container startup failed
	at org.testcontainers.containers.GenericContainer.doStart(GenericContainer.java:322)
	at org.testcontainers.containers.GenericContainer.start(GenericContainer.java:302)
	at org.testcontainers.containers.GenericContainer.starting(GenericContainer.java:1008)
	at org.testcontainers.containers.FailureDetectingExternalResource$1.evaluate(FailureDetectingExternalResource.java:29)
	at org.junit.runners.ParentRunner$3.evaluate(ParentRunner.java:306)
	at org.junit.runners.BlockJUnit4ClassRunner$1.evaluate(BlockJUnit4ClassRunner.java:100)
	at org.junit.runners.ParentRunner.runLeaf(ParentRunner.java:366)
	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:103)
	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:63)
	at org.junit.runners.ParentRunner$4.run(ParentRunner.java:331)
	at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:79)
	at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:329)
	at org.junit.runners.ParentRunner.access$100(ParentRunner.java:66)
	at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:293)
	at org.junit.runners.ParentRunner$3.evaluate(ParentRunner.java:306)
	at org.junit.runners.ParentRunner.run(ParentRunner.java:413)
	at com.google.testing.junit.runner.internal.junit4.CancellableRequestFactory$CancellableRunner.run(CancellableRequestFactory.java:89)
	at org.junit.runner.JUnitCore.run(JUnitCore.java:137)
	at org.junit.runner.JUnitCore.run(JUnitCore.java:115)
	at com.google.testing.junit.runner.junit4.JUnit4Runner.run(JUnit4Runner.java:112)
	at com.google.testing.junit.runner.BazelTestRunner.runTestsInSuite(BazelTestRunner.java:153)
	at com.google.testing.junit.runner.BazelTestRunner.main(BazelTestRunner.java:84)
Caused by: org.testcontainers.containers.ContainerFetchException: Can't get Docker image: RemoteDockerImage(imageNameFuture=java.util.concurrent.CompletableFuture@16c069df[Completed normally], imagePullPolicy=DefaultPullPolicy(), dockerClient=LazyDockerClient.INSTANCE)
	at org.testcontainers.containers.GenericContainer.getDockerImageName(GenericContainer.java:1265)
	at org.testcontainers.containers.GenericContainer.logger(GenericContainer.java:600)
	at org.testcontainers.containers.GenericContainer.doStart(GenericContainer.java:311)
	... 21 more
Caused by: java.lang.IllegalStateException: Previous attempts to find a Docker environment failed. Will not retry. Please see logs and check configuration
	at org.testcontainers.dockerclient.DockerClientProviderStrategy.getFirstValidStrategy(DockerClientProviderStrategy.java:83)
	at org.testcontainers.DockerClientFactory.getOrInitializeStrategy(DockerClientFactory.java:113)
	at org.testcontainers.DockerClientFactory.client(DockerClientFactory.java:134)
	at org.testcontainers.LazyDockerClient.getDockerClient(LazyDockerClient.java:14)
	at org.testcontainers.LazyDockerClient.inspectImageCmd(LazyDockerClient.java:12)
	at org.testcontainers.images.LocalImagesCache.refreshCache(LocalImagesCache.java:42)
	at org.testcontainers.images.AbstractImagePullPolicy.shouldPull(AbstractImagePullPolicy.java:24)
	at org.testcontainers.images.RemoteDockerImage.resolve(RemoteDockerImage.java:62)
	at org.testcontainers.images.RemoteDockerImage.resolve(RemoteDockerImage.java:25)
	at org.testcontainers.utility.LazyFuture.getResolvedValue(LazyFuture.java:20)
	at org.testcontainers.utility.LazyFuture.get(LazyFuture.java:27)
	at org.testcontainers.containers.GenericContainer.getDockerImageName(GenericContainer.java:1263)
	... 23 more

FAILURES!!!
Tests run: 2,  Failures: 2


BazelTestRunner exiting with a return value of 1
JVM shutdown hooks (if any) will run now.
The JVM will exit once they complete.

-- JVM shutdown starting at 2020-04-04 15:45:21 --

FAIL: //src/test/java:RedisBackedCacheTest (see /home/jenkins/.cache/bazel/_bazel_jenkins/5d16d83cb36bd7256ba2784654e11e2d/execroot/__main__/bazel-out/k8-fastbuild/testlogs/src/test/java/RedisBackedCacheTest/test.log)
INFO: Elapsed time: 44.147s, Critical Path: 43.60s
INFO: 4 processes: 4 remote.
INFO: Build completed, 1 test FAILED, 5 total actions
//src/test/java:RedisBackedCacheTest                                     FAILED in 23.7s
    FAILED  RedisBackedCacheTest.testNotFindingAValueThatWasNotInserted (11.9s)
    FAILED  RedisBackedCacheTest.testFindingAnInsertedValue (0.0s)
Test cases: finished with 0 passing and 2 failing out of 2 test cases

INFO: Build completed, 1 test FAILED, 5 total actions

```