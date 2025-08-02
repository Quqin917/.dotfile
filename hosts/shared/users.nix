{ ... }:
{
  # Define a user account
  users.users.quqin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ];
  };
}
