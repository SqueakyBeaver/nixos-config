{inputs, ...}: final: prev: {
  pixelflasher = prev.pixelflasher.overrideAttrs (finalAttrs: prevAttrs: {
    src = inputs.pixelflasher;
    version = "8.14.3.1"; # Probably won't update the version bc idc
  });
}
