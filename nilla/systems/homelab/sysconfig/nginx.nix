# Might not use this, since I don't trust myself to secure everything very well yet
{
  config,
  lib,
  pkgs,
  project,
  ...
}: {
  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."squeakybeaver.duckdns.org" = {
      # enableACME = true;
      locations."/plantuml" = {
        proxyPass = "http://127.0.0.1:62300"; # Plantuml
        proxyWebsockets = true; # idk if i need this
        extraConfig = ''
          proxy_ssl_server_name on;
          proxy_pass_header Authorization;
        '';
      };
    };
  };

  networking.networkmanager.connectionConfig = {
    "connection.mdns" = 2;
  };

  age.secrets.duckdns.file = ../../../../secrets/duckdns.age;

  security.acme = {
    acceptTerms = true;
    defaults.email = "squeaky.beaver4133@protonmail.com";

    certs."squeakybeaver.duckdns.org" = {
      extraDomainNames = [];
      dnsProviders = "duckdns";
      dnsPropogationCheck = true;
      credentialsFile = config.age.secrets.duckdns.path;
    };
  };

  services.duckdns = {
    enable = true;
    tokenFile = config.age.secrets.duckdns.path;
    domains = ["squeakybeaver"];
  };

  users.users.nginx.extraGroups = ["acme"];
}
