# 前言

​	学习了Java的 ClassLoader，很多同学会把Java和Android的ClassLoader搞混，甚至会认为Android中的ClassLoader和Java中的ClassLoader是一样的，这显然是不对的。这一篇文章我们就来学习Android中的ClassLoader，来看看它和Java中的ClassLoader有何不同。



# ClassLoader的类型

​	我们知道Java中的ClassLoader可以加载jar文件和Class文件（本质是加载Class文件），这一点在Android中并不适用，因为无论是DVM还是ART它们加载的不再是Class文件，而是dex文件，这就需要重新设计ClassLoader相关类，我们先来学习ClassLoader的类型。

​	Android中的ClassLoader类型和Java中的ClassLoader类型类似，也分为两种类型，分别是系统ClassLoader和自定义ClassLoader。其中系统ClassLoader包括三种分别是BootClassLoader、PathClassLoader和DexClassLoader。



## BootClassLoader

​	Android系统启动时会使用BootClassLoader来预加载常用类，与Java中的BootClassLoader不同，它并不是由C/C++代码实现，而是由Java实现的，BootClassLoade的代码如下所示。 

@libcore/ojluni/src/main/java/java/lang/ClassLoader.java

```java
class BootClassLoader extends ClassLoader {
    private static BootClassLoader instance;
    @FindBugsSuppressWarnings("DP_CREATE_CLASSLOADER_INSIDE_DO_PRIVILEGED")
    public static synchronized BootClassLoader getInstance() {
        if (instance == null) {
            instance = new BootClassLoader();
        }
        return instance;
    }
	...
}
```

​	BootClassLoader是ClassLoader的内部类，并继承自ClassLoader。BootClassLoader是一个单例类，需要注意的是BootClassLoader的访问修饰符是默认的，只有在同一个包中才可以访问，因此我们在应用程序中是无法直接调用的。



##  PathClassLoader

​	Android系统使用PathClassLoader来加载系统类和应用程序的类，如果是加载非系统应用程序类，则会加载data/app/目录下的dex文件以及包含dex的apk文件或jar文件，不管是加载那种文件，最终都是要加载dex文件，在这里为了方便理解，我们将dex文件以及包含dex的apk文件或jar文件统称为dex相关文件。PathClassLoader不建议开发直接使用。来查看它的代码： 

@libcore/dalvik/src/main/java/dalvik/system/PathClassLoader.java

```java
public class PathClassLoader extends BaseDexClassLoader {
    public PathClassLoader(String dexPath, ClassLoader parent) {
        super(dexPath, null, null, parent);
    }
    public PathClassLoader(String dexPath, String librarySearchPath, ClassLoader parent) 	 {
        super(dexPath, null, librarySearchPath, parent);
    }
}
```

​	PathClassLoader继承自BaseDexClassLoader，很明显PathClassLoader的方法实现都在BaseDexClassLoader中。从PathClassLoader的构造方法也可以看出它遵循了双亲委托模式。

PathClassLoader的构造方法有三个参数：

- dexPath：dex文件以及包含dex的apk文件或jar文件的路径集合，多个路径用文件分隔符分隔，默认文件分隔符为‘：’。
- librarySearchPath：包含 C/C++ 库的路径集合，多个路径用文件分隔符分隔分割，可以为null。
- parent：ClassLoader的parent。



## DexClassLoader

​	DexClassLoader可以加载dex文件以及包含dex的apk文件或jar文件，也支持从SD卡进行加载，这也就意味着DexClassLoader可以在应用未安装的情况下加载dex相关文件。因此，它是热修复和插件化技术的基础。来查看它的代码，如下所示。：

@libcore/dalvik/src/main/java/dalvik/system/DexClassLoader.java

```java
public class DexClassLoader extends BaseDexClassLoader {
    public DexClassLoader(String dexPath, String optimizedDirectory,
            String librarySearchPath, ClassLoader parent) {
        super(dexPath, new File(optimizedDirectory), librarySearchPath, parent);
        }
}
```

​	DexClassLoader构造方法的参数要比PathClassLoader多一个optimizedDirectory参数，参数optimizedDirectory代表什么呢？我们知道应用程序第一次被加载的时候，为了提高以后的启动速度和执行效率，Android系统会对dex相关文件做一定程度的优化，并生成一个ODEX文件，此后再运行这个应用程序的时候，只要加载优化过的ODEX文件就行了，省去了每次都要优化的时间，而参数optimizedDirectory就是代表存储ODEX文件的路径，这个路径必须是一个内部存储路径。  PathClassLoader没有参数optimizedDirectory，这是因为PathClassLoader已经默认了参数optimizedDirectory的路径为：`/data/dalvik-cache`。DexClassLoader 也继承自BaseDexClassLoader ，方法实现也都在BaseDexClassLoader中。

 

#ClassLoader的继承关系

相关的类关系如下图所示:

![](pics/0002.png)

​	可以看到上面一共有8个ClassLoader相关类，其中有一些和Java中的ClassLoader相关类十分类似，下面简单对它们进行介绍：

- ClassLoader是一个抽象类，其中定义了ClassLoader的主要功能。BootClassLoader是它的内部类。
- SecureClassLoader类和JDK8中的SecureClassLoader类的代码是一样的，它继承了抽象类ClassLoader。SecureClassLoader并不是ClassLoader的实现类，而是拓展了ClassLoader类加入了权限方面的功能，加强了ClassLoader的安全性。
- URLClassLoader类和JDK8中的URLClassLoader类的代码是一样的，它继承自SecureClassLoader，用来通过URl路径从jar文件和文件夹中加载类和资源。
- InMemoryDexClassLoader是Android8.0新增的类加载器，继承自BaseDexClassLoader，用于加载内存中的dex文件。
- BaseDexClassLoader继承自ClassLoader，是抽象类ClassLoader的具体实现类，PathClassLoader和DexClassLoader都继承它。



# 地址总结

1. [刘望舒博客: Android解析ClassLoader（二）Android中的ClassLoader]( https://blog.csdn.net/itachi85/article/details/78276837)
2. [浅析dex文件加载机制](https://www.cnblogs.com/lanrenxinxin/p/4712224.html)
3. [热修复入门：Android 中的 ClassLoader](http://www.jianshu.com/p/96a72d1a7974) 