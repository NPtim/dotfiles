{
  inputs, 
  ...
}:
{
  home-manager = {
    users.tim = import ./home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
