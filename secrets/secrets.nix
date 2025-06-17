let
  beaver-thinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIMoljotaFu7Cb75gS0MD6fbqtKrxurAmkesi70xRtV7";
in {
  "duckdns.age".publicKeys = [beaver-thinkpad];
}
