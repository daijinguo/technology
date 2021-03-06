
emacs 相关快捷键


# 与文件相关命令

| 快捷键  | 说明                                          |
| ------- | --------------------------------------------- |
| C-x C-f | 查找文件并在一个新缓冲区里打开它              |
| C-x C-v | 读入另外一个文件替换掉用 'C-x C-f' 打开的文件 |
| C-x i   | 把文件插入当前光标位置                        |
| C-x C-s | 保存文件                                      |
| C-x C-w | 把缓冲区内容写入一个文件                      |
| C-x C-c | 推出 emacs                                    |


# 光标移动命令速查表

| 快捷键 | 说明                                    |
| ------ | --------------------------------------- |
| C-f    | 光标前移一个字符(右)                    |
| C-b    | 光标后移一个字符(左)                    |
| C-n    | 光标后移一行(下)                        |
| ESC f  | 光标前移一个单词                        |
| ESC b  | 光标后移一个单词                        |
| C-a    | 光标移动到行首                          |
| C-e    | 光标移动行尾                            |
| ESC e  | 光标前移一个句子                        |
| ESC a  | 光标后移一个句子                        |
| ESC }  | 光标前移一个段落                        |
| ESC {  | 光标后移一个段落                        |
| C-v    | 屏幕上卷一屏                            |
| ESC v  | 屏幕下卷一屏                            |
| C-x ]  | 光标前移一页                            |
| C-x [  | 光标后移一页                            |
| ESC <  | 光标移动文件开头                        |
| ESC >  | 光标移动到文件尾                        |
| C-I    | 重新绘制屏幕画面，当前行放在画面中心    |
| none   | goto-line 光标移动到文件第 N 行         |
| none   | goto-char 光标前进到文件第 N 字符       |
| ESC n  | 重复执行 n 次后续命令                   |
| C-u n  | 重复执行 n 次后续命令(省略 n 时重复4次) |

说明: none 表示先 ESC x 在执行后续的命令的全名, 比如 `goto-line`


# 文本删除命令

| 快捷键              | 命令名称                | 说明                 |
| ------------------- | ----------------------- | -------------------- |
| C-d                 | delete-char             | 删除光标位置上的字符 |
| DEL                 | delete-backward-char    | 删除光标前面的字符   |
| ESC d               | kill-word               | 删除光标后面的单词   |
| ESC DEL             | backwird-kill-word      | 删除光标前面的单词   |
| C-k                 | kill-line               | 从光标位置删除到尾部 |
| ESC k               | kill-sentence           | 删除光标后面的句子   |
| C-x DEL             | backwork-kill-sentence  | 删除光标前面的句子   |
| C-y 或 SHIFT-INSET  | yank                    | 恢复被删除的文本     |
| C-w 或 SHIFT-DELETE | kill-region             | 删除文本块           |
| none                | kill-paragraph          | 删除光标后面的段落   |
| none                | backward-kill-paragraph | 删除光标前面的段落   |


# 文本块操作命令

| 快捷键              | 命令名称                | 说明                                 |
| ------------------- | ----------------------- | ------------------------------------ |
| C-@ 或者 C-SPACE    | set-mark-command        | 标记文本块的开始(或者结束)位置       |
| C-x C-x             | exchange-point-and-mark | 互换插入点和文本标记位置             |
| C-x DEL             | backwork-kill-sentence  | 删除光标前面的句子                   |
| C-y 或 SHIFT-INSET  | yank                    | 恢复被删除的文本                     |
| C-w 或 SHIFT-DELETE | kill-region             | 删除文本块                           |
| ESC w 或 C-INSERT   | kill-ring-save          | 复制文本块 (便于使用'C-y'命令来粘贴) |


| C-y 或 SHIFT-INSET  | yank                    | 恢复被删除的文本                     |
| C-w 或 SHIFT-DELETE | kill-region             | 删除文本块                           |
| ESC w 或 C-INSERT   | kill-ring-save          | 复制文本块 (便于使用'C-y'命令来粘贴) |


