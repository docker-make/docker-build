FROM codercom/code-server:4.141.0
USER root
RUN apt-get update && \
    apt-get --no-install-recommends --no-install-suggests -y install \
    zsh zoxide vim iputils-ping git dnsutils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 完全移除 coder 用户的 sudo 权限（安全加固）
# RUN deluser coder sudo 2>/dev/null || true && \
#     rm -f /etc/sudoers.d/coder

USER coder
WORKDIR /home/coder
COPY --chown=coder:coder ./zsh.sh /home/coder/zsh.sh
# oh-my-zsh 已自带 zsh-syntax-highlighting / zsh-autosuggestions，无需再 clone；
# 安装后把它们加入 .zshrc 的 plugins，否则插件不会被加载
RUN RUNZSH=no CHSH=no sh /home/coder/zsh.sh && \
    rm -f /home/coder/zsh.sh && \
    sed -i 's|^plugins=(.*)|plugins=(git zsh-syntax-highlighting zsh-autosuggestions)|' /home/coder/.zshrc

# 设置默认 shell 为 zsh
ENV SHELL=/bin/zsh
WORKDIR /home/coder
