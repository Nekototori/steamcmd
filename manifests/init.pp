define steamcmd (
  $ensure = 'present',
  $app_id,
  $steamcmd_path = 'C:/programdata/chocolatey/bin/',
  $install_dir = "%programfiles(x86)%/Steam/steamapps/common/${title}",
  $username = undef,
  $password = undef,
  $anonymous_login = true,
) {

# Determine login method.
  if $anonymous_login == true {
    $login = 'anonymous'
  } else {
    if ($username == undef) or ($password == undef) {
      fail("When disabling anonymous login, username and password must be specified")
    } else {
      $login = "$username $password"
    }
  }

  if $ensure == 'present' {
    exec { "Installing ${title} via SteamCMD":
      command => "steamcmd.exe +login ${login} +force_install_dir i\"${install_dir}\" +app_update ${app_id} +quit",
      unless  => "cmd.exe /c if not exist \"%${install_dir}%\" exit 1",
      path    => [$steamcmd_path, 'C:/Windows/System32'],
      timeout => 0,
    }
  } elsif $ensure == 'absent' {
    exec { "Removing ${title} via SteamCMD":
      command => "steamcmd.exe +login ${login} +app_uninstall ${app_id} +quit",
      unless  => "cmd.exe /c if exist \"%${install_dir}%\" exit 1",
      path    => [$steamcmd_path, 'C:/Windows/System32'],
    }
  }
}
