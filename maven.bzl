load("@rules_jvm_external//:defs.bzl", "maven_install")

def maven():

    maven_install(
        name = "maven",
        artifacts = [
            "org.slf4j:slf4j-api:1.7.30",
            "redis.clients:jedis:3.2.0",
            "com.google.code.gson:gson:2.8.6",
            "com.google.guava:guava:23.0",
        ],
        repositories = [
            "https://maven.google.com",
            "https://repo1.maven.org/maven2",
            "https://packages.confluent.io/maven/"
        ],
        fetch_sources = True,
        version_conflict_policy = "pinned",
    )

    maven_install(
        name = "maven_test",
        artifacts = [
            "junit:junit:4.13",
            "ch.qos.logback:logback-classic:1.2.3",
            "org.testcontainers:testcontainers:1.13.0"
        
        ],
        repositories = [
            "https://maven.google.com",
            "https://repo1.maven.org/maven2",
        ],
        fetch_sources = True,
    )