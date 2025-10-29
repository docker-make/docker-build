FROM codercom/code-server:latest
USER root
RUN apt-get update && \
    apt-get --no-install-recommends --no-install-suggests -y install \
    zsh zoxide vim iputils-ping git dnsutils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
COPY ./zsh.sh /home/coder/zsh.sh
RUN chmod 777 /home/coder/zsh.sh

# 完全移除 coder 用户的 sudo 权限（安全加固）
# RUN deluser coder sudo 2>/dev/null || true && \
#     rm -f /etc/sudoers.d/coder

USER coder
WORKDIR /home/coder
COPY ./zsh.sh /home/coder/zsh.sh
RUN RUNZSH=no CHSH=no sh /home/coder/zsh.sh && \
    rm -rf /home/coder/zsh.sh

WORKDIR /home/coder/.oh-my-zsh/plugins
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git && \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git

# 设置默认 shell 为 zsh
ENV SHELL=/bin/zsh
WORKDIR /home/coder
