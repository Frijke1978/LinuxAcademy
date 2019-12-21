Gradle is a powerful build automation tool, but in order to use it you need to know the basics of how it works. This lesson will guide you through the core concepts of Gradle automation, and it will demonstrate creating a simple build.gradle file. After completing this lesson, you should have a basic working knowledge of how to implement and execute tasks in Gradle.
More more information on Gradle, check out the official Gradle site: https://gradle.org

Here is the final build.gradle from the demo:
plugins {
  id 'com.moowork.node' version '1.2.0'
}

task sayHello << {
  println 'Hello, World!'
}

task anotherTask << {
  println 'This is another task'
}
If you have the gradle wrapper installed in your project (for example, by using gradle init), you can run the build defined in this build.gradle like so:
./gradlew sayHello