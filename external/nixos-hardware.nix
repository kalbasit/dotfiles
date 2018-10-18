let
  pinnedVersion = builtins.fromJSON (builtins.readFile ./nixos-hardware-version.json);
  pinned = builtins.fetchGit {
    inherit (pinnedVersion) url rev;
  };
in
  pinned
