{
  description = ''load .env variables'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."loadenv-master".dir   = "master";
  inputs."loadenv-master".owner = "nim-nix-pkgs";
  inputs."loadenv-master".ref   = "master";
  inputs."loadenv-master".repo  = "loadenv";
  inputs."loadenv-master".type  = "github";
  inputs."loadenv-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."loadenv-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}