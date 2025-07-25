{ pkgs, home-manager, username, ... }: {
  home-manager.users.${username} = { pkgs, ... }: {
    home.file = {
      ".ssh/config".text = ''
        Host *
          IdentityAgent ~/.1password/agent.sock

        Include ~/.ssh/1Password/config
      '';
      ".config/1Password/ssh/agent.toml".text = ''
        [[ssh-keys]]
        vault = "SSH"

        [[ssh-keys]]
        vault = "Notflix"

        [[ssh-keys]]
        vault = "Team Technology"
        account = "MySmartHeart AG"
      '';
    };
  };

  programs.bash.interactiveShellInit = ''
    source /home/${username}/.config/op/plugins.sh
    export SSH_AUTH_SOCK=~/.1password/agent.sock
  '';

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "${username}" ];
    };
    chromium = { extensions = [ "aeblfdkhhhdcdjpifhhbdiojplfjncoa" ]; };
  };
}

