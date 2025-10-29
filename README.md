# 一些自用的 Docker 构建

## 项目结构

- `caddy/` - Caddy 服务器镜像（带多个插件）
- `code/` - Code Server 镜像（带 zsh 和工具）

## 使用 GitHub Actions 构建

### 前置准备

如果需要推送镜像到 Docker Hub，请在 GitHub 仓库设置中添加以下 Secrets：

1. 进入仓库的 `Settings` -> `Secrets and variables` -> `Actions`
2. 添加以下 secrets：
   - `DOCKER_USERNAME`: 你的 Docker Hub 用户名
   - `DOCKER_PASSWORD`: 你的 Docker Hub 访问令牌 (Access Token)

### 手动触发构建

1. 进入 GitHub 仓库的 `Actions` 标签页
2. 选择 `Build Docker Image` workflow
3. 点击 `Run workflow` 按钮
4. 选择配置：
   - **选择要构建的目录**: 选择 `caddy` 或 `code`
   - **镜像仓库地址**: 默认为 `docker.io` (Docker Hub)
   - **是否推送到镜像仓库**: 选择是否推送（如果只是测试构建可以选 false）
   - **自定义镜像标签**: 可选，留空则使用默认标签
     - 默认标签：`latest` 和 `日期-commit` (如 `2025-10-10-abc1234`)
     - 自定义标签示例：`v1.0.0`、`dev`、`staging` 等
5. 点击 `Run workflow` 开始构建

### 镜像标签策略

**默认标签（不填写自定义标签时）**：
- `latest` - 最新版本
- `YYYY-MM-DD-<commit>` - 带日期和 Git commit SHA 的标签

**自定义标签**：
如果填写了自定义标签，将只使用该标签。适用场景：
- 版本发布：`v1.0.0`、`v2.1.3`
- 环境标记：`dev`、`staging`、`prod`
- 功能分支：`feature-xxx`
- 测试版本：`beta`、`alpha`

### 本地构建

```bash
# 构建 caddy 镜像
cd caddy
docker build -t caddy:latest .

# 构建 code 镜像
cd code
docker build -t code:latest .

# 使用自定义标签
docker build -t caddy:v1.0.0 .
```

## 镜像说明

### Caddy 镜像

基于官方 Caddy 镜像，添加了以下插件：
- jsonc-adapter
- cloudflare DNS
- tencentcloud DNS
- alidns DNS
- caddy-cloudflare-ip
- caddy-trusted-cloudfront
- caddy-l4
- caddy-ratelimit

### Code Server 镜像

基于官方 code-server 镜像，添加了：
- zsh + oh-my-zsh
- zoxide
- vim
- 常用网络工具（ping, dig 等）
- zsh 插件（语法高亮、自动补全）