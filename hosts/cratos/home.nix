{
  home-manager.users.kalbasit = { ... }: {
    imports = [
      ../../modules/home
    ];

    mine.workstation.enable = true;
    mine.batteryNotifier.enable = true;
  };
}
