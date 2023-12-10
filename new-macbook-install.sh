# check if brew is installed
if ! command -v brew &> /dev/null
then
  echo "brew could not be found"
  echo "installing brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew upgrade

brew install autoconf
brew install autojump
brew install awk
brew install aws-iam-authenticator
brew install awscli
brew install azure-cli
brew install brotli
brew install c-ares
brew install ca-certificates
brew install cffi
brew install cmake
brew install common-aliases
brew install copyfile
brew install corepack
brew install coreutils
brew install direnv
brew install docker
brew install docker-completion
brew install docker-compose
brew install docutils
brew install eksctl
brew install fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
brew install gettext
brew install git
brew install git-extras
brew install git-flow
brew install gnu-sed
brew install go
brew install grep
brew install groonga
brew install gzip
brew install helm
brew install history
brew install htop
brew install icu4c
brew install jq
brew install k9s
brew install kubectl
brew install kubernetes-cli
brew install libidn2
brew install libnghttp2
brew install libunistring
brew install libuv
brew install lz4
brew install m4
brew install mariadb
brew install mecab
brew install mecab-ipadic
brew install mpdecimal
brew install msgpack
brew install mysql-client
brew install ncurses
brew install node
brew install npm
brew install nvm
brew install oniguruma
brew install openjdk
brew install openssl
brew install openssl@3
brew install opentofu
brew install pcre
brew install pcre2
brew install pip
brew install pkg-config
brew install pnpm
brew install pycparser
brew install pyenv
brew install pylint
brew install python
brew install python-setuptools
brew install python@3.11
brew install python@3.12
brew install readline
brew install six
brew install sqlite
brew install tmux
brew install unzip
brew install webp
brew install wget
brew install xz
brew install yq
brew install zlib
brew install zplug
brew install zsh-autosuggestions
brew install zsh-git-prompt
brew install zsh-interactive-cd
brew install zsh-syntax-highlighting
brew install zstd

# Install casks
brew install --cask dbeaver-community
brew install --cask visual-studio-code
brew install --cask slack
brew install --cask google-chrome
brew install --cask spotify
brew install --cask mattermost
brew install --cask 1password

brew cleanup

# if there is no zshrc file
if [ ! -f ~/.zshrc ]; then
  # Create .zshrc file
  touch ~/.zshrc

  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo 'alias ll="ls -lha"' >> ~/.zshrc
  echo 'alias k="kubectl"' >> ~/.zshrc

  echo 'export ZSH=$HOME/.oh-my-zsh' >> ~/.zshrc
  # Oh-my-zsh theme
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
  # Oh-my-zsh plugins
  echo 'plugins=(' >> ~/.zshrc
  echo 'aliases' >> ~/.zshrc
  echo 'autojump' >> ~/.zshrc
  echo 'argocd' >> ~/.zshrc
  echo 'aws' >> ~/.zshrc
  echo 'azure' >> ~/.zshrc
  echo 'command-not-found' >> ~/.zshrc
  echo 'common-aliases' >> ~/.zshrc
  echo 'copyfile' >> ~/.zshrc
  echo 'direnv' >> ~/.zshrc
  echo 'dirhistory' >> ~/.zshrc
  echo 'docker' >> ~/.zshrc
  echo 'docker-compose' >> ~/.zshrc
  echo 'fzf' >> ~/.zshrc
  echo 'git' >> ~/.zshrc
  echo 'git-extras' >> ~/.zshrc
  echo 'git-flow' >> ~/.zshrc
  echo 'git-prompt' >> ~/.zshrc
  echo 'history' >> ~/.zshrc
  echo 'kubectl' >> ~/.zshrc
  echo 'kubectx' >> ~/.zshrc
  echo 'kube-ps1' >> ~/.zshrc
  echo 'zsh-autosuggestions' >> ~/.zshrc
  echo 'zsh-syntax-highlighting' >> ~/.zshrc
  echo 'zsh-interactive-cd' >> ~/.zshrc
  echo 'wd' >> ~/.zshrc
  echo ')' >> ~/.zshrc

  echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc
  
  echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> ~/.zshrc

  echo '' >> ~/.zshrc

  echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc
fi

source ~/.zshrc
