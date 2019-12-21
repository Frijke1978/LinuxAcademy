Before you can begin using Gradle to create build automation, you need to be able to install it. This lesson will walk you through the process of installing Gradle. It will also introduce you to a slightly more advanced way of installing and using Gradle, known as the Gradle Wrapper. After completing this lesson, you should be able to install Gradle and the Gradle Wrapper so that you can execute Gradle builds.

You can find more information about installing Gradle at https://gradle.org/install/ 

Here are the commands used in the demo to install gradle:
cd ~/
wget -O ~/gradle-4.7-bin.zip https://services.gradle.org/distributions/gradle-4.7-bin.zip
sudo yum -y install unzip java-1.8.0-openjdk
sudo mkdir /opt/gradle
sudo unzip -d /opt/gradle/ ~/gradle-4.7-bin.zip
sudo vi /etc/profile.d/gradle.sh
Put this text into gradle.sh:
export PATH=$PATH:/opt/gradle/gradle-4.7/bin
Then set permissions on gradle.sh:
sudo chmod 755 /etc/profile.d/gradle.sh
Finally, after logging out of the server and logging back in:
gradle --version
And the commands used to install and run the Gradle Wrapper:
cd ~/
mkdir my-project
cd my-project
gradle wrapper
./gradlew build