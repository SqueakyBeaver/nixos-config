{
  config = {
    services.openssh = {
      enable = true;
      settings.UseDns = true;
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
