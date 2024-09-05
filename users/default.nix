{ username, ... }: {
  imports = [ ./${username} ];
  users.groups.wireshark = { };
}
