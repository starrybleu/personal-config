wsl + cmder + zsh 조합으로 잘 쓰고 있었는데 언제부터인가 Paste Multi lines 가 잘 안 되었는데 cmder 설정으로 해결함.

Settings -> Startup -> Tasks
Predefined tasks 에

```
set "PATH=%ConEmuBaseDirShort%\wsl;%PATH%" & %ConEmuBaseDirShort%\conemu-cyg-64.exe --log --wsl -cur_console:pnm:/mnt/c -t zsh -l
```

로 설정해준다.

힌트 : https://github.com/Maximus5/ConEmu/issues/1314
