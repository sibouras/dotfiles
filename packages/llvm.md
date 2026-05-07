```bash
# https://apt.llvm.org/

# To install the latest stable version:(this installs an older version than the next method)
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# To install a specific version of LLVM:
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh version_number

# symlinks
sudo ln -sf /usr/bin/lld-22 /usr/bin/lld
sudo ln -sf /usr/bin/lldb-22 /usr/bin/lldb
sudo ln -sf /usr/bin/clang-22 /usr/bin/clang
sudo ln -sf /usr/bin/clangd-22 /usr/bin/clangd

# uninstall
sudo apt remove clang-20 clangd-20 lld-20
# NOTE: try uninstalling llvm-20 first next time and see if it removes clang, clangd and lld
sudo apt remove llvm-20
sudo apt autoremove
sudo mandb
```

some output of `sudo ./llvm.sh 22`

```log
+ PKG='clang-22 lldb-22 lld-22 clangd-22'
+ [[ 0 -eq 1 ]]
+ apt-get install -y clang-22 lldb-22 lld-22 clangd-22
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following package was automatically installed and is no longer required:
  liblldb-20
Use 'sudo apt autoremove' to remove it.
The following additional packages will be installed:
  clang-tools-22 libclang-common-22-dev libclang-cpp22 libclang-rt-22-dev libclang1-22 liblldb-22 libllvm22 libz3-4 libz3-dev llvm-22 llvm-22-dev
  llvm-22-linker-tools llvm-22-runtime llvm-22-tools python3-lldb-22
Suggested packages:
  clang-22-doc wasi-libc llvm-22-doc
The following packages will be REMOVED:
  lldb-20 python3-lldb-20
The following NEW packages will be installed:
  clang-22 clang-tools-22 clangd-22 libclang-common-22-dev libclang-cpp22 libclang-rt-22-dev libclang1-22 liblldb-22 libllvm22 libz3-4 libz3-dev lld-22
  lldb-22 llvm-22 llvm-22-dev llvm-22-linker-tools llvm-22-runtime llvm-22-tools python3-lldb-22
0 upgraded, 19 newly installed, 2 to remove and 0 not upgraded.
Need to get 166 MB of archives.
```
