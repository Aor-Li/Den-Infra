{ lib, ... }:
{
  den.schema.user = {
    # use stand-alone home-manager
    classes = lib.mkDefault [ ];
  };

  # 用户身份信息（供 dev/git 等特性使用）。
  #
  # 声明在 home schema 而非 user schema：den 只在 host 已声明时才把 user 实体
  # 绑进 home 上下文（`_module.args.user = userByName`），像 `aor@philo` 这类
  # 未声明 host 的独立 home 拿到的 user 是 null。而 `home` 上下文对所有 home
  # 恒定可用，故身份声明在这一层才能覆盖全部 home。值在 profile.nix 逐个赋。
  den.schema.home.options = {
    fullname = lib.mkOption {
      type = lib.types.str;
      description = "Full name of the home's owner (used as git user.name).";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "Email of the home's owner (used as git user.email).";
    };
  };
}
