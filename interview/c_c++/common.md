
常用 c/c++ 相关面试题

+ <font color=#0099ff size=4>volatile</font>  
定义为volatile的变量是说这变量可能会被意想不到地改变，即在你程序运行过程中一直会变，你希望这个值被正确的处理，每次从内存中去读这个值，而不是因编译器优化从缓存的地方读取，比如读取缓存在寄存器中的数值，从而保证volatile变量被正确的读取。  
可以访问： https://blog.csdn.net/k346k346/article/details/46941497