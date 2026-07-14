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
| 框架级配置组织 | 集中在 `metas/framework/` | 拆分为 `metas/options/*`（schema 的 option 声明，如 `host.nix`/`user.nix`）与 `metas/config/*`（schema 的默认值/includes 接线，如 `default.nix`/`host.nix`/`user.nix`） |

图例：✅ 已迁移　🟡 部分迁移　❌ 未迁移　⏸️ 暂缓（不在本阶段范围内）

## `feature/nix`

| 旧模块 | 状态 | 说明 |
| --- | --- | --- |
| `settings.nix` | 🟡 | nixos/darwin 的 `nix.settings`、substituters、trusted-users、allowUnfree 已迁移。缺 home 层 sops `nix.conf` 模板（`github_access_token`），依赖 sops 一起迁移。 |
| `home-manager.nix` | ✅ | `programs.home-manager.enable` 已迁；`username`/`homeDirectory` 由 den 处理，`stateVersion` 由 `metas/config/default.nix` 提供。 |
| `nh.nix` | ✅ | `nix/nh.nix`。`homeManager` 层 `programs.nh` 原样迁移，`flake` 路径改为 `"${config.home.homeDirectory}/Den-Infra"`（假定各主机都克隆到 `~/Den-Infra`，如有主机路径不同需在该主机 entity 文件里覆盖）。 |
| `nix-index.nix` | ✅ | `nix/nix-index.nix`。`homeManager` 层 `programs.nix-index.enable` 原样迁移。 |
| `nix-ld.nix` | ✅ | `nix/nix-ld.nix`。`nixos` 层 `programs.nix-ld` 原样迁移。 |
| `secrets/secrets.nix` + `.sops.yaml` | ⏸️ 暂缓 | 不归入 `feature/nix`，等后续设计独立密钥管理 aspect 域时再迁移。详见文末「sops-nix / secrets 迁移」说明。 |

## `feature/system`（旧 `features/sys`）

| 旧模块 | 状态 | 说明 |
| --- | --- | --- |
| `base.nix` | ✅ | `hostname` 已由 `system/hostname.nix`、`stateVersion` 已由 `metas/config/default.nix` 覆盖。基础 `systemPackages`（vim/wget/tree/htop/btop/fd/fzf）与 `environment.variables.EDITOR = "nvim"` 迁移为 `system/tools.nix`（`den.aspects.system.tools`，nixos+darwin 共用）。 |
| `boot-loader.nix` | ✅ | `system/core/physical-nixos.nix` 按 `env==physical && distro==nixos` 开启 systemd-boot；vm/wsl 默认不开，等价旧逻辑。 |
| `wsl.nix` | ✅ | `system/core/wsl-nixos.nix`。差异：新版注释掉了 `wslConf.network.hostname`，如需保留请补上。 |
| `user.nix` | ✅ | 用 `nix eval` 实测 Enten/Tobimune：`den.provides.define-user` 默认已给出 `isNormalUser=true`、`extraGroups=[wheel,networkmanager]`，与旧版一致，无需新建文件。唯一差异：`initialPassword` 旧值为 `""`（允许免密登录），新默认是 `null`（不设初始密码，更安全）；如需恢复免密登录需另行决定。 |
| `fonts.nix` | ✅ | `system/fonts.nix`。`nixos`（字体包+fontconfig 基础设施）+ `homeManager`（个人字体包与默认字体覆盖）原样迁移。过程中发现 `den.schema.home.includes` 之前是空的，导致 `feature/system.*` 的 `homeManager` 键从未接到 standalone home 配置——已补上 `den.schema.home.includes = [ den.aspects.system ]`（现在位于 `metas/config/user.nix`，与 `metas/config/host.nix` 的 `den.schema.host.includes` 对应），这也是后续 `xdg.nix`/`shell.nix` 能生效的前提。注：`fontconfig.defaultFonts` 具体选哪个字体属于审美偏好，概念上更接近 appearance/ricing，未来若建立该域可从这里拆出。 |
| `i18n.nix` | ✅ | `system/i18n.nix`。时区 `Asia/Shanghai`、locale、`networking.timeServers` 原样迁移。 |
| `shell.nix` | ✅ | `system/shell.nix`。`homeManager` 层 `COLORTERM = "truecolor"` 原样迁移，文件内留 TODO：未来迁移 `feature/dev` 时考虑合并进 `dev/shell.nix`。 |
| `sleep.nix` | ✅ | `system/sleep.nix`。新增 `host.sleep`（bool）option，`config.sleep = lib.mkDefault (config.role != "server")`——即 `role == "server"` 默认禁用休眠，desktop/laptop 默认保持系统默认休眠，任意主机可在 `entity/hosts/<Host>.nix` 显式覆盖。logind 配置改用 `services.logind.settings.Login.*`（新 nixpkgs 写法，替代旧的已弃用 `lidSwitch`/`extraConfig`）。已用 `nix eval` 验证 Tobimune(server)/Enten(desktop) 行为符合预期。 |
| `xdg.nix` | ✅ | `system/xdg.nix`。`homeManager` 层 `xdg.userDirs` 原样迁移。 |

## 迁移优先级

1. ✅ **nixos 基础项**（影响可用性）：`base.nix` 的 systemPackages+EDITOR（→`system/tools.nix`）、`i18n.nix`、`user.nix` 的用户组（已确认无需新建文件）、`sleep.nix`（→改用 `role`-based 默认值）。
2. **home 层基础**（进行中）：`fonts.nix`、`xdg.nix`、`shell.nix`(COLORTERM)、`nix-index.nix`、`nh.nix`。
3. **sops 密钥链**：暂缓，见下方说明。
4. `nix-ld.nix` 可随时迁移（独立、无依赖）。

## sops-nix / secrets 迁移（暂缓）

sops-nix 本质是“密钥/密文管理”，既不属于 `feature/nix`（围绕 nix 命令行本身：settings/nh/nix-index/nix-ld）也不属于 `feature/system`（主机基础配置）。旧仓库把它放进 `features/nix/secrets/` 更多是历史原因。此外，真正生效的 `.sops.yaml`、`secrets.yaml`、per-secret 路径绑定实际在旧仓库的 `modules/profiles/users/aor/secrets/`（用户级），`features/nix/secrets/.sops.yaml` 里的 key 只是占位符。

结论：本阶段不做 sops-nix 接线，等后续设计出单独的密钥管理 aspect 域（例如 `feature/secrets`）时再规划迁移；`settings.nix` 里缺失的 home 层 `nix.conf`（`github_access_token` 模板）依赖这条链路，届时一并处理。用户级的密钥数据与绑定应归入未来 `entity/users/aor.nix` 的迁移范畴。
