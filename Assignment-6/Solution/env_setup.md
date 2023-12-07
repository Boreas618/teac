# 安装依赖
使用apt安装qemu模拟器和aarch64工具链。

在ubuntu系统下，可以使用apt安装本实验需要的所有依赖。

本次实验需要使用Aarch64(arm64)工具链对我们编译器得到的汇编文件进行汇编和链接，生成可执行文件。然后，我们将使用qemu模拟器提供的arm64环境运行程序。

```
sudo apt install qemu qemu-system qemu-user
sudo apt install gcc-aarch64-linux-gnu
```

压缩包`gcc-arm-8.2-2018.11-x86_64-arm-linux-gnueabihf.tar.xz`，然后在 linux 环境里执行：

```shell
$ cd ~
$ tar xf gcc-arm-8.2-2018.11-x86_64-arm-linux-gnueabihf.tar.xz
$ echo "export PATH=~/gcc-arm-8.2-2018.11-x86_64-arm-linux-gnueabihf/bin:\$PATH" >> ~/.bashrc # or ~/.zshrc
```

重启终端，尝试：

```shell
$ arm-linux-gnueabihf-g++ -v # 查看版本，若出现版本信息则说明安装成功
```

qemu模拟器用于执行交叉编译出的arm机器码，同交叉编译器配套在后面的实验中使用。

从 elearning 上下载压缩包`qemu-6.2.0.tar.xz`，然后在 linux 环境里执行：

```shell
$ sudo apt install ninja-build
$ ninja --version

$ cd ~
$ tar xf qemu-6.2.0.tar.xz
$ cd qemu-6.2.0
$ mkdir build
$ cd build
$ ../configure --target-list=arm-linux-user
$ make -j4
$ sudo make install
```

安装完毕后，运行
```
aarch64-linux-gnu-gcc --version
qemu-aarch64 -version
```
检查工具链和qemu安装状态，返回版本信息即说明安装成功。

# 汇编和链接
```
aarch64-linux-gnu-gcc test.S -o test --static
```

完成安装后可以通过以下命令进行测试：

```shell
$ qemu-arm --version # 查看版本，若出现版本信息则说明安装成功
```

假设汇编代码保存在文件`a.s`中，希望将汇编出的机器码保存至`a.out`，则使用交叉编译器和qemu对汇编进行仿真的指令为：

```shell
$ arm-linux-gnueabihf-gcc a.s libsysy.a --static -o a.out # 编译出机器码
$ qemu-arm a.out # 使用qemu执行机器码

# If you get `qemu-arm: Unable to reserve 0xffff0000 bytes`:
# Try `qemu-arm -B 0 a.out`
```

其中`libsysy.a`为SysY运行时库，包含putint、timestart等函数，同样可以从elearing下载。使用交叉编译器时，请将它和汇编代码放在同一目录下。
