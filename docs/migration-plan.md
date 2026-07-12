# 迁移计划：`feature/nix` 与 `feature/system`

将旧仓库 `infra`（`flake.aor.modules.feature.*`）迁移到新仓库 `Den-Infra`（`den` + dendritic，`den.aspects.*`）的进度追踪。本文件只覆盖 `feature/nix` 与 `feature/system`（旧 `features/sys`）两个模块域。

## 两套系统的映射关系

| 维度 | 旧 `infra` | 新 `Den-Infra` |
| --- | --- | --- |
| 命名空间 | `flake.aor.modules.feature.*` | `den.aspects.*` |
| home 层 | `home` 子模块 | `homeManager` 子模块 |
| 主机分类 | `hostConfig.type`（desktop/laptop/server/vm/wsl） | 拆成 `host.env`（physical/virtual/wsl）+ `host.role`（desktop/laptop/server） |
| 用户 | `hostConfig.owner.username` | `host.users` + den 的 `define-user`/`primary-user` provider |
| 带 option 的模块 | 直接写 `options` | 改用 den 的 schema 机制 |
| 特性专属 input | 集中声明 | 就近在特性文件里声明 `flake-file.inputs`，改后 `nix run .#write-flake` |

图例：✅ 已迁移　🟡 部分迁移　❌ 未迁移

## `feature/nix`

| 旧模块 | 状态 | 说明 |
| --- | --- | --- |
| `settings.nix` | 🟡 | nixos/darwin 的 `nix.settings`、substituters、trusted-users、allowUnfree 已迁移。缺 home 层 sops `nix.conf` 模板（`github_access_token`），依赖 sops 一起迁移。 |
| `home-manager.nix` | ✅ | `programs.home-manager.enable` 已迁；`username`/`homeDirectory` 由 den 处理，`stateVersion` 由 `entity/default.nix` 提供。 |
| `nh.nix` | ❌ | `programs.nh`（含 clean 自动清理）。迁移时把 `flake = ".../infra"` 改成 `Den-Infra`。 |
| `nix-index.nix` | ❌ | home 层 `programs.nix-index`。 |
| `nix-ld.nix` | ❌ | nixos 层 `programs.nix-ld`（独立、无依赖）。 |
| `secrets/secrets.nix` + `.sops.yaml` | ❌ | sops-nix 密钥体系，需新增 `sops-nix` input；牵动 `settings.nix` 的 nix.conf 模板。 |

## `feature/system`（旧 `features/sys`）

| 旧模块 | 状态 | 说明 |
| --- | --- | --- |
| `base.nix` | 🟡 | `hostname` 已由 `system/hostname.nix`、`stateVersion` 已由 `entity/default.nix` 覆盖。缺基础 `systemPackages`（vim/wget/tree/htop/btop/fd/fzf）与 `environment.variables.EDITOR = "nvim"`。 |
| `boot-loader.nix` | ✅ | `system/core/physical-nixos.nix` 按 `env==physical && distro==nixos` 开启 systemd-boot；vm/wsl 默认不开，等价旧逻辑。 |
| `wsl.nix` | ✅ | `system/core/wsl-nixos.nix`。差异：新版注释掉了 `wslConf.network.hostname`，如需保留请补上。 |
| `user.nix` | 🟡 | den 的 `define-user` 会创建用户，但旧的 `extraGroups = [ "wheel" "networkmanager" ]`、`isNormalUser`、`initialPassword=""` 是否被默认覆盖需确认；`networkmanager` 组大概率需单独迁移。 |
| `fonts.nix` | ❌ | nixos 字体包 + fontconfig，以及 home 层字体。 |
| `i18n.nix` | ❌ | 时区 `Asia/Shanghai`、locale、`networking.timeServers`。 |
| `shell.nix` | ❌ | home 层 `COLORTERM = "truecolor"`（区别于 `dev/shell.nix`）。 |
| `sleep.nix` | ❌ | 自定义 `mode` 选项 + logind/systemd 禁止休眠；迁移需用 den 的 schema/option 机制重写。 |
| `xdg.nix` | ❌ | home 层 `xdg.userDirs`。 |

## 迁移优先级

1. **nixos 基础项**（影响可用性）：`base.nix` 的 systemPackages+EDITOR、`i18n.nix`、`user.nix` 的用户组，确认 `sleep.nix`。
2. **home 层基础**：`fonts.nix`、`xdg.nix`、`shell.nix`(COLORTERM)、`nix-index.nix`、`nh.nix`。
3. **sops 密钥链**（耦合最重，最后做）：`secrets.nix` + `.sops.yaml` + `settings.nix` 的 nix.conf 模板（需新增 `sops-nix` input）。
4. `nix-ld.nix` 可随时迁移（独立、无依赖）。

> 建议起手：先从零依赖、快速见效的 `i18n.nix` + `base.nix` 系统包开始。
