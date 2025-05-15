# Homebrew 설치
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> /Users/$USER/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install wget

# Oh My Zsh 설정
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/blimmer/zsh-aws-vault.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-aws-vault

# Fuzzy Finder 설치
brew install fzf

# asdf 설치
brew install asdf

# HTTPie 설치
brew install httpie

# mysql 8 설치
brew install mysql@8.0

# z 설치 (업데이트 없는 fasd 의 대체제)
brew install z

# nvm 설치
brew install nvm
mkdir ~/.nvm
echo "
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
" >> ~/.zshrc
nvm install v18
npm install --global yarn

# zsh plugins 수정
vim ~/.zshrc # zsh plugins 수정
```
plugins=(
git
zsh-syntax-highlighting
zsh-autosuggestions
zsh-aws-vault
bundler dotenv macos git-flow
z fzf history themes
docker
docker-compose
)
```

# zsh theme 설정
vim ~/.zshrc
```
ZSH_THEME="kennethreitz"
```

# 테마의 zsh PROMPT(PS1) 설정
vim ~/.oh-my-zsh/themes/kennethreitz.zsh-theme
```
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

my_prompt_aws_vault() {
  local vault_segment
  vault_segment="`prompt_aws_vault_segment`"
  if [[ $vault_segment == '' ]];then
    echo "%{$fg[cyan]%}[%*]"
    return 0
  fi

  if [[ $vault_segment == *"prod"* ]];then
   echo "%{$fg[magenta]%}[%*] %{$fg[red]%} [AWS$vault_segment] %{$reset_color%}"
    return 0
  fi

  echo "%{$fg[cyan]%}[%*] %{$fg[white]%} [AWS$vault_segment] %{$reset_color%}"
}

PROMPT='$(virtualenv_prompt_info)%{$fg[green]%}%c \
$(my_prompt_aws_vault)\
$(git_prompt_info)\
\
%{$fg[red]%}%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='%{$fg[blue]%}%~%{$reset_color%} ${return_code} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$reset_color%}%{[03m%}%{$fg[blue]%}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="!%{$reset_color%} "
```

# AWS granted 설치 (assume 사용)
brew tap common-fate/granted
brew install granted

# gossm 설치
brew tap gjbae1212/gossm
brew install gossm


# Github ssh key 설정
ssh-keygen -t ed25519 -C "$MY_EMAIL"
touch ~/.ssh/config
vim ~/.ssh/config # 아래 내용 입력
```
Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
```
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub # 이렇게 복사된 값을 Github ssh key 추가 기능 통해 저장하기
ssh -T git@github.com # github 접속 확인

# Github GPG key 설정
brew install gpg
gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG
gpg --armor --export {위에서 확인된 값}
git config --global user.email {GPG 생성시 사용한 이메일 주소}
git config --global user.name {GPG 생성시 사용한 이름}
git config --global user.signingkey {GPG 생성 후 나온 signingkey}
git config --global commit.gpgsign true
git config --global gpg.program gpg

# bundle 로 ruby gem registry 에서 다운받도록 토큰 설정 등
vim ~/.bundle/config # 파일 내용
```
---
BUNDLE_HTTPS://RUBYGEMS__PKG__GITHUB__COM/DRAMANCOMPANY/: "starrybleu:ghp_xxxxxxx"
BUNDLE_JOBS: "2"
BUNDLE_SET: "build.cflags -Wno-error=incompatible-function-pointer-types"
```

# remember-api 프로젝트에서
CFLAGS="-Wno-error=incompatible-function-pointer-types" bundle install

