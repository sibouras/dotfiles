```bash
# https://apt.llvm.org/
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# change stable version number
sudo ln -sf /usr/bin/lld-20 /usr/bin/lld
sudo ln -sf /usr/bin/lldb-20 /usr/bin/lldb
sudo ln -sf /usr/bin/clang-20 /usr/bin/clang
sudo ln -sf /usr/bin/clang-20 /usr/bin/clang

# uninstall
sudo apt remove clang-20 clangd-20 lld-20 lldb-20
```
