title: java 类加载器与双亲委托模型
date: 2018/07/25 18:30



# 类加载器

## 加载类的开放性

​        类加载器（ClassLoader）是Java语言的一项创新，也是Java流行的一个重要原因。在类加载的第一阶段“加载”过程中，需要通过一个类的全限定名来获取定义此类的二进制字节流，完成这个动作的代码块就是**类加载器**。这一动作是放在Java虚拟机外部去实现的，以便让应用程序自己决定如何获取所需的类。

​         虚拟机规范并没有指明二进制字节流要从一个Class文件获取，或者说根本没有指明从哪里获取、怎样获取。这种开放使得Java在很多领域得到充分运用，例如：

- 从ZIP包中读取，这很常见，成为JAR，EAR，WAR格式的基础
- 从网络中获取，最典型的应用就是Applet
- 运行时计算生成，最典型的是动态代理技术，在java.lang.reflect.Proxy中，就是用了ProxyGenerator.generateProxyClass来为特定接口生成形式为“*$Proxy”的代理类的二进制字节流
- 有其他文件生成，最典型的JSP应用，由JSP文件生成对应的Class类 



## 类加载器与类的唯一性

​        类加载器虽然只用于实现类的加载动作，但是对于任意一个类，都需要由加载它的**类加载器**和这个**类本身**共同确立其在Java虚拟机中的**唯一性**。

​        通俗的说，JVM中两个类是否“相等”，首先就必须是**同一个类加载器加载**的，否则，即使这两个类来源于同一个Class文件，被同一个虚拟机加载，只要类加载器不同，那么这两个类必定是不相等的。

​        “相等”，包括代表类的Class对象的equals()方法、isAssignableFrom()方法、isInstance()方法的返回结果，也包括使用instanceof关键字做对象所属关系判定等情况。

以下代码说明了不同的类加载器对instanceof关键字运算的结果的影响:

```Java
package com.jvm.classloading;

import java.io.IOException;
import java.io.InputStream;

public class ClassLoaderTest {
    public static void main(String[] args) throws Exception {
        // 自定义类加载器
        ClassLoader myLoader = new ClassLoader() {
            @Override
            public Class<?> loadClass(String name) throws ClassNotFoundException {
                try {
                    String fileName = name.substring(name.lastIndexOf(".") + 1) + ".class";
                    InputStream is = getClass().getResourceAsStream(fileName);
                    if (is == null) {
                        return super.loadClass(fileName);
                    }
                    byte[] b = new byte[is.available()];
                    is.read(b);
                    return defineClass(name, b, 0, b.length);   
                } catch (IOException e) {
                    throw new ClassNotFoundException();
                }
            }
        };

        // 使用ClassLoaderTest的类加载器加载本类
        Object obj1 = ClassLoaderTest.class.getClassLoader().loadClass("com.jvm.classloading.ClassLoaderTest").newInstance();
        System.out.println(obj1.getClass());
        System.out.println(obj1 instanceof com.jvm.classloading.ClassLoaderTest);

        // 使用自定义类加载器加载本类
        Object obj2 = myLoader.loadClass("com.jvm.classloading.ClassLoaderTest").newInstance();
        System.out.println(obj2.getClass());
        System.out.println(obj2 instanceof com.jvm.classloading.ClassLoaderTest);
    }
}
```

运行结果:

````
class com.jvm.classloading.ClassLoaderTest
true
class com.jvm.classloading.ClassLoaderTest
false
````

程序说明：

​         myLoader是自定义的类加载器，可以用来加载与自己在同一路径下的Class文件。main函数的第一部分使用系统加载主类ClassLoaderTest的类加载器加载ClassLoaderTest，输出显示，obj1的所属类型检查正确，这是虚拟机中有2个ClassLoaderTest类，一个是主类，另一个是main()方法中加载的类，由于这两个类使用同一个类加载器加载并且来源于同一个Class文件，因此这两个类是完全相同的。

​         第二部分使用自定义的类加载器加载ClassLoaderTest，`class com.jvm.classloading.ClassLoderTest`显示，obj2确实是类`com.jvm.classloading.ClassLoaderTest`实例化出来的对象，但是第二句输出false。此时虚拟机中有3个ClassLoaderTest类，由于第3个类的类加载器与前面2个类加载器不同，虽然来源于同一个Class文件，但它是一个独立的类，所属类型检查是返回结果自然是false。



#  双亲委派模型

##  类加载器种类

​        从Java虚拟机的角度来说，只存在两种不同的类加载器：

+ 一种是启动类加载器（Bootstrap  ClassLoader），这个类加载器使用C++语言实现（HotSpot虚拟机中），是虚拟机自身的一部分；
+ 另一种就是所有其他的类加载器，这些类加载器都有Java语言实现，独立于虚拟机外部，并且全部继承自java.lang.ClassLoader。



从开发者的角度，类加载器可以细分为：

- 启动（Bootstrap）类加载器：负责将 Java_Home/lib下面的类库加载到内存中（比如rt.jar）。由于引导类加载器涉及到虚拟机本地实现细节，开发者无法直接获取到启动类加载器的引用，所以不允许直接通过引用进行操作。
- 标准扩展（Extension）类加载器：是由 Sun 的  ExtClassLoader（sun.misc.Launcher$ExtClassLoader）实现的。它负责将Java_Home  /lib/ext或者由系统变量 java.ext.dir指定位置中的类库加载到内存中。开发者可以直接使用标准扩展类加载器。
- 应用程序（Application）类加载器：是由 Sun 的  ppClassLoader（sun.misc.Launcher$AppClassLoader）实现的。它负责将系统类路径（CLASSPATH）中指定的类库加载到内存中。开发者可以直接使用系统类加载器。由于这个类加载器是ClassLoader中的getSystemClassLoader()方法的返回值，因此一般称为**系统（System）加载器**。

​        除此之外，还有自定义的类加载器，它们之间的层次关系被称为类加载器的**双亲委派模型**。该模型要求除了顶层的启动类加载器外，其余的类加载器都应该有自己的父类加载器，而这种父子关系一般通过**组合（Composition）关系**来实现，而不是通过继承（Inheritance）。

![](pics/0001.jpeg)

## 双亲委派模型
### 双亲委派模型过程

​        某个特定的类加载器在接到加载类的请求时，首先将加载任务委托给父类加载器，依次递归，如果父类加载器可以完成类加载任务，就成功返回；只有父类加载器无法完成此加载任务时，才自己去加载。

​	使用双亲委派模型的好处在于**Java类随着它的类加载器一起具备了一种带有优先级的层次关系**。例如类java.lang.Object，它存在在rt.jar中，无论哪一个类加载器要加载这个类，最终都是委派给处于模型最顶端的Bootstrap ClassLoader进行加载，因此Object类在程序的各种类加载器环境中都是同一个类。相反，如果没有双亲委派模型而是由各个类加载器自行加载的话，如果用户编写了一个java.lang.Object的同名类并放在ClassPath中，那系统中将会出现多个不同的Object类，程序将混乱。因此，如果开发者尝试编写一个与rt.jar类库中重名的Java类，可以正常编译，但是永远无法被加载运行。

### 双亲委派模型的系统实现

​	在 java.lang.ClassLoader 的 loadClass() 方法中，先检查是否已经被加载过，若没有加载则调用父类加载器的 loadClass() 方法，若父加载器为空则默认使用启动类加载器作为父加载器。如果父加载失败，则抛出 ClassNotFoundException 异常后，再调用自己的findClass()方法进行加载。

```Java
protected synchronized Class<?> loadClass(String name,boolean resolve)throws ClassNotFoundException{
    //check the class has been loaded or not
    Class c = findLoadedClass(name);
    if(c == null){
        try{
            if(parent != null){
                c = parent.loadClass(name,false);
            }else{
                c = findBootstrapClassOrNull(name);
            }
        }catch(ClassNotFoundException e){
            //if throws the exception ,the father can not complete the load
        }
        if(c == null){
            c = findClass(name);
        }
    }
    if(resolve){
        resolveClass(c);
    }
    return c;
}
```

注意，双亲委派模型是Java设计者推荐给开发者的类加载器的实现方式，并不是强制规定的。大多数的类加载器都遵循这个模型，但是JDK中也有较大规模破坏双亲模型的情况，例如线程上下文类加载器（Thread Context ClassLoader）的出现，具体分析可以参见周志明著《深入理解Java虚拟机》。



# 几个总结

## 预定义类加载器和双亲委派机制

1. JVM预定义的三种类型类加载器：

   - **启动（Bootstrap）类加载器**：是用本地代码实现的类装入器，它负责将 `<Java_Runtime_Home>/lib`下面的类库加载到内存中（比如`rt.jar`）。由于引导类加载器涉及到虚拟机本地实现细节，开发者无法直接获取到启动类加载器的引用，所以不允许直接通过引用进行操作。
   - **标准扩展（Extension）类加载器**：是由 Sun 的 `ExtClassLoader（sun.misc.Launcher$ExtClassLoader）`实现的。它负责将`< Java_Runtime_Home >/lib/ext`或者由系统变量 `java.ext.dir`指定位置中的类库加载到内存中。开发者可以直接使用标准扩展类加载器。
   - **系统（System）类加载器**：是由 Sun 的 `AppClassLoader（sun.misc.Launcher$AppClassLoader）`实现的。它负责将系统类路径（`CLASSPATH`）中指定的类库加载到内存中。开发者可以直接使用系统类加载器。

   除了以上列举的三种类加载器，还有一种比较特殊的类型 — 线程上下文类加载器。

2. 双亲委派机制描述 
    某个特定的类加载器在接到加载类的请求时，首先将加载任务委托给父类加载器，**依次递归**，如果父类加载器可以完成类加载任务，就成功返回；只有父类加载器无法完成此加载任务时，才自己去加载。



## 几点思考

1. Java虚拟机的第一个类加载器是Bootstrap，这个加载器很特殊，**它不是Java类，因此它不需要被别人加载，它嵌套在Java虚拟机内核里面，也就是JVM启动的时候Bootstrap就已经启动，它是用C++写的二进制代码（不是字节码）**，它可以去加载别的类。

   这也是我们在测试时为什么发现`System.class.getClassLoader()`结果为null的原因，这并不表示System这个类没有类加载器，而是它的加载器比较特殊，是`BootstrapClassLoader`，由于它不是Java类，因此获得它的引用肯定返回null。

2. 委托机制具体含义 
    当Java虚拟机要加载一个类时，到底派出哪个类加载器去加载呢？

   - 首先当前线程的类加载器去加载线程中的第一个类（假设为类A）。 
      注：当前线程的类加载器可以通过Thread类的getContextClassLoader()获得，也可以通过setContextClassLoader()自己设置类加载器。
   - 如果类A中引用了类B，Java虚拟机将使用加载类A的类加载器去加载类B。
   - 还可以直接调用`ClassLoader.loadClass()`方法来指定某个类加载器去加载某个类。

3. **委托机制的意义 — 防止内存中出现多份同样的字节码** 
    比如两个类A和类B都要加载System类：

   - 如果不用委托而是自己加载自己的，那么类A就会加载一份System字节码，然后类B又会加载一份System字节码，**这样内存中就出现了两份System字节码。**
   - 如果使用委托机制，会递归的向父类查找，也就是**首选用Bootstrap尝试加载**，如果找不到再向下。这里的System就能在Bootstrap中找到然后加载，如果此时类B也要加载System，也从Bootstrap开始，此时**Bootstrap发现已经加载过了System那么直接返回内存中的System即可而不需要重新加载**，这样内存中就只有一份System的字节码了。

## 一道面试题

- 能不能自己写个类叫`java.lang.System`？

  **答案：**通常不可以，但可以采取另类方法达到这个需求。 
   **解释：**为了不让我们写System类，类加载采用委托机制，这样可以保证爸爸们优先，爸爸们能找到的类，儿子就没有机会加载。而System类是Bootstrap加载器加载的，就算自己重写，也总是使用Java系统提供的System，**自己写的System类根本没有机会得到加载。**

  ​        但是，我们可以**自己定义一个类加载器来达到这个目的**，为了避免双亲委托机制，这个类加载器也必须是特殊的。由于系统自带的三个类加载器都加载特定目录下的类，如果我们自己的类加载器放在一个特殊的目录，那么系统的加载器就无法加载，也就是最终还是由我们自己的加载器加载。



# 相关链接地址

+ http://www.cnblogs.com/lanxuezaipiao/p/4138511.html

+ https://blog.csdn.net/u011080472/article/details/51332866

+ 刘望舒 https://blog.csdn.net/itachi85

  https://blog.csdn.net/itachi85/article/details/78088701