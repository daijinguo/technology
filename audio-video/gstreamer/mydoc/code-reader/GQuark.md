
[glib库中的GQuark介绍](https://blog.csdn.net/xtx1990/article/details/8161390)

&emsp;&emsp;为了在程序中标识一块数据，你一般有两种方式可选：`数字或字符串`。但是这两者都有一些缺点。数字是非常难以辨认的。如果你开始粗略的知道需要多少标签，你就可以定义一个枚举类型和一些字符符号。但是，你没法在运行的时候动态添加标签。

``Gquark本质上还是哈希表存储字符串，一个数字对应一个字符串``

&emsp;&emsp;另一方面，你可以在运行的时候动态的添加或修改字符串，而且它们是很容易理解的。   但是，字符串比较要比数字比较花更长的时间，而且在内存中管理字符串有一些你可能不愿意处理的额外麻烦。

&emsp;&emsp;GLib 提供了 GQuark 类型，它整合了数字的简单和字符串的易用。在它内部，它就是一个易于比较和复制的整形数。 GLib 将这些数字映射为你的字符串，并且你可以在任何时间取得字符串所对应的值。

要创建一个 quark ，使用下面两个函数之一：
```c
GQuark  quark;
gchar  *string;
quark = g_quark_from_string(string);
quark = g_quark_from_static_string("string");
```
&emsp;&emsp;这两个函数都是以字符串作为它们唯一的参数。它们的区别是 g_quark_from_string() 会在映射的时候创建一个字符串的拷贝，但是 g_quark_from_static_string() 并不会。

:warning:  小心使用 `g_quark_from_static_string()` 。在每次执行它的时候会节约很少的 CPU 和内存，但是，在你的程序中增加了附加的依赖性可能会导致你的程序有一些 bug ，所以，或许节约的那一点开销并不值得你去使用该函数。


如果你想检验某个字符串是否有一个 quark 值，调用：
```c
g_quark_try_string(string);
```
这个函数的返回值是该字符串所对应的 quark 值。  
&emsp;如果返回 0 的话，说明没有与这个字符串相对应的 quark值


从 quark 恢复到 string 使用：
```c
string = g_quark_to_string(quark);
```
如果它执行成功，它将会返回 quark 对应的字符串的指针。但是你不能在这个指针上调用 free() ，因为这个字符串并不是一个拷贝。  
下面是一个简单的 demo：
```c
GQuark *my_quark = 0;
my_quark = g_quark_from_string("Chevre");
if (!g_quark_try("Cottage Cheese"))
{
    g_print("There isn't any quark for \"Cottage Cheese\"\n");
}
g_print("my_quark is a representation of %s\n", g_quark_to_string(my_quark));
```


:warning: GQuark 值是分配给字符串的数字，并且很容易测试它们的等同性。然而，它们并没有数字顺序。你不能用 quark 值来进行字母顺序测试。因此，你不能用它们作为排序关键字。如果你想比较 quark 所代表的字符串，你必须先用 g_quark_to_string() 来提取相应的字符串，然后才可以使用 strcmp() 或 g_ascii_strcasecmp() 。
