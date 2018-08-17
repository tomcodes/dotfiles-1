FROM ubuntu:16.04

# Install sudo
RUN apt-get update \
  && apt-get install -y sudo \
  && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create user
ENV HOME /home/dev
RUN useradd --create-home --home-dir $HOME dev \
  && chown -R dev:dev $HOME
RUN echo "dev:dev" | chpasswd
RUN usermod -aG sudo dev

# Define current user
USER dev

# Add and run install script
COPY --chown=dev:dev terminal.sh /tmp/terminal.sh
RUN chmod +x /tmp/terminal.sh && ./tmp/terminal.sh && rm /tmp/terminal.sh

# Set zsh as default
ENV SHELL=/bin/zsh

# Run dotfiles
RUN mkdir $HOME/.config \
  && git clone https://github.com/loric-/dotfiles.git $HOME/.config/dotfiles
RUN cd $HOME/.config/dotfiles && python3 link.py --only-terminal

# Apply less layout
RUN lesskey

# Install vim plugins
RUN vim -c 'PlugInstall' -c 'qa!' > /dev/null

# Save home as volume
VOLUME $HOME

# Set workdir
WORKDIR $HOME/Lab

# Start zsh by default
ENTRYPOINT ["/bin/zsh"]
