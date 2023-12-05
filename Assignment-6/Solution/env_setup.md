
本文假设同学们使用的是Ubuntu系统。在ubuntu系统下，可以使用apt安装本实验需要的所有依赖。本次实验需要使用Aarch64(arm64)工具链对我们编译器得到的汇编文件进行汇编和链接，生成可执行文件。然后，我们将使用qemu模拟器提供的arm64环境运行程序。


# 安装依赖
使用apt安装qemu模拟器和aarch64工具链。
```
sudo apt install qemu qemu-system qemu-user
sudo apt install gcc-aarch64-linux-gnu
```
安装完毕后，运行
```
aarch64-linux-gnu-gcc --version
qemu-aarch64 -version
```
检查工具链和qemu安装状态，返回版本信息即说明安装成功。

# 汇编和链接
```
aarch64-linux-gnu-gcc test.S -o test
```
