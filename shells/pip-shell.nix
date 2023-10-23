{ pkgs ? import <nixpkgs-unstable> {
  config.allowUnfree = true;
} }:
(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python310
    python310Packages.pip
    python310Packages.virtualenv
    cudaPackages.cudatoolkit
  ]);
  runScript = "bash";
}).env
