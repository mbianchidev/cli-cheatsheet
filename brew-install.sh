# check if brew is installed
if ! command -v brew &> /dev/null
then
  echo "brew could not be found"
  echo "installing brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install autoconf
brew install autojump
brew install awscli
brew install aws-iam-authenticator
brew install azure-cli
brew install ca-certificates
brew install cmake
brew install common-aliases
brew install copyfile
brew install corepack
brew install coreutils
brew install direnv
brew install dirhistory
brew install docker
brew install docker-compose
brew install eksctl
brew install fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
brew install git
brew install git-extras
brew install git-flow
brew install git-prompt
brew install go
brew install gzip
brew install helm
brew install history
brew install kubectl
brew install kubectx
brew install kube-ps1
brew install mysql-client
brew install npm
brew install nvm
brew install node
brew install openjdk
brew install openssl
brew install pnpm
brew install pip
brew install python
brew install pyenv
brew install pylint
brew install tmux
brew install webp
brew install zlib
brew install zplug
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install zsh-interactive-cd

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# if there is no zshrc file
if [ ! -f ~/.zshrc ]; then
  # Create .zshrc file
  touch ~/.zshrc

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

  echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc
fi



