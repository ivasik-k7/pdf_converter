#!/bin/bash

# set -e

if command -v rbenv &>/dev/null; then
    RBENV_VERSION=$(rbenv --version | awk '{print $2}')

    rbenv versions

    echo "rbenv is installed. Version: $RBENV_VERSION"
else
    echo "Installing rbenv..."
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo export PATH="$HOME/.rbenv/bin:$PATH" >>~/.bashrc
    echo eval "$(rbenv init --no-rehash -)" >>~/.bashrc
    source ~/.bashrc
fi

RUBY_VERSION=$(awk '/^ruby/{print $2}' Gemfile | tr -d '"')

if rbenv versions | grep -q "$RUBY_VERSION"; then
    echo "Ruby version $RUBY_VERSION is installed."
else
    echo "Installing Ruby $RUBY_VERSION..."
    rbenv install "$RUBY_VERSION"
    echo "Installing local Ruby version to $RUBY_VERSION"

    rbenv versions
fi

if rbenv local &>/dev/null; then
    CURRENT_RUBY_VERSION=$(rbenv local)
    echo "A local Ruby version is set: $CURRENT_RUBY_VERSION"

    echo "Installing Ruby version $RUBY_VERSION"

    rbenv global "$RUBY_VERSION"
    rbenv local "$RUBY_VERSION"
    rbenv rehash
else
    echo "No local Ruby version set."
    rbenv global "$RUBY_VERSION"
    rbenv local "$RUBY_VERSION"
    rbenv rehash
    echo "Set local Ruby version to $RUBY_VERSION"
fi

if command -v bundle &>/dev/null; then
    echo "Installing Gemfile dependencies..."
    bundle install
else
    echo "Bundler is not installed. Installing bundler..."

    gem install bundler

    if [ $? -eq 0 ]; then
        echo "Bundler installed successfully."
        echo "Installing Gemfile dependencies..."
        bundle install
    else
        echo "Failed to install Bundler. Please check your Ruby and Gem environment."
    fi
fi
