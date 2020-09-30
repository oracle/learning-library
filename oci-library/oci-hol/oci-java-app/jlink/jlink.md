# jlink

## Introduction

In a nutshell, `jlink` is a tool that can create custom Java runtime that includes only the modules required by an application. Reducing the numbers of modules will reduce the overall size of that custom Java runtime image, a concern especially important when a Java application runs within a container. `jlink` has been part of the JDK tooling since JDK 9.

Estimated Lab Time: 5 minutes

### Objectives
- This optional lab will show you how *`jlink`* can greatly improve the size of a Java runtime image.

## Using `jlink`


First create a basic application and compile it.


```
mkdir ~/jlink-test && cd ~/jlink-test
nano Test.java
javac Test.java
```

```
class Test {
   public static void main(String args[]) {
     System.out.println("Hello jlink!");
   }
}
```

You then need to know which module(s) this application requires to run. For that, you will use another JDK tool, `jdeps`.

`jdeps Test.class`

You can see that in this case only the `java.base` module is required. Using this information, you can create a custom runtime by passing to `jlink` the target location of the custom runtime and the list of module(s) to include in it.

```
jlink --output custom-runtime --add-modules java.base
```

You can now check the size of the generated Java runtime image.

```
du -chs custom-runtime
```

This small (<50MB!) custom Java runtime is limited but it can, nevertheless, runs any application that only require the `java.base` module such the example above.


## Using `jlink` with Helidon applications 


The previous example could not be more simple! As such, it does not reflect the reality as any real application will be way more complex than a simple "Hello World" class. The challenge when creating custom Java runtime mostly comes from the dependencies the application is using as you have to figure out which modules are used, and hence required in your custom runtime image. As you saw, a tool such as `jdpes` can help to identify those modules. The good news is that more and more Java frameworks support `jlink` out-of-the-box! As a developer, you don't have to worry about making sure that you have correctly identified all the modules required by your application and its dependencies as the framework tooling will often take care of that!

To create a jlink based custom Java runtime image, Helidon is using a Maven profile. To use it, simply issue the following Maven command from the project directory.

```
cd ~/odl-java-hol
mvn package -Pjlink-image -Djlink.image.defaultJvmOptions="--enable-preview"
```

![](.././images/lab11-1.png " ")

The result are impressive as the total size (JDK, the application and its dependcies) went from ~320MB to ~80MB, a ~75% gain!

💡 The Helidon `jlink` Maven profile also creates, by default, a CDS (Class Data Sharing) archive. CDS is a JDK feature that helps reduce the startup time and memory footprints of Java applications. Check [here]((https://docs.oracle.com/en/java/javase/14/vm/class-data-sharing.html#GUID-7EAA3411-8CF0-4D19-BD05-DF5E1780AA91) from additional details.

A convenient startup script is also created in the process, it handles for example the JVM parameters such as `--enable-preview` in this particular case. To run the application with its custom Java runtime image, simply invoke this script.

```
target/conference-app/bin/start
```

To get additional details, just use its help.
```
conference-app/bin/start --help
```

As you can see, using `jlink` with Helidon is simple and straight forward!


## Wrap-up

`jlink` is a tool that can assemble and optimize a set of modules and their dependencies to create a custom, i.e. optimized, run-time Java image. Optimizing the size of a Java runtime is critical when an Java application is embedded with its Java runtime into a container. Reducing the overall container image size will improve the startup time of this container. Moreover, smaller container leads to better resource utilization of the container platform.  It should be mentioned that to use `jlink` the application does not need to be modularized! Moreover, `jlink` is available since JDK 9 so there is no valid reason to not leverage `jlink` today!

**More resources**
* [JEP 282: `jlink`](https://openjdk.java.net/jeps/282)
* [The jlink Command](https://docs.oracle.com/en/java/javase/14/docs/specs/man/jlink.html)
* [Helidon SE — Custom Runtime Images with `jlink`](https://helidon.io/docs/v2/#/se/guides/37_jlink_image)
* [Helidon Maven Plugin](https://github.com/oracle/helidon-build-tools/tree/master/helidon-maven-plugin#goal-jlink-image)
* [Class Data Sharing](https://docs.oracle.com/en/java/javase/14/vm/class-data-sharing.html#GUID-7EAA3411-8CF0-4D19-BD05-DF5E1780AA91)

## Acknowledgements

 - **Author** - [David Delabassee](https://delabassee.com)
 - **Last updated By** - Kamryn Vinson, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.

 







