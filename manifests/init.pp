define steamcmd (
  $ensure = 'present',
  $app_id,
  $steamcmd_path = 'C:/programdata/chocolatey/bin/',
  $install_dir = "%programfiles(x86)%/Steam/steamapps/common/${title}",
) {
  if $ensure == 'present' {
    exec { "Installing ${title} via SteamCMD":
      command => "steamcmd.exe +login anonymous +force_install_dir ${install_dir} +app_update ${app_id} +quit",
      unless  => "if exist \"%${install_dir}%\" exit 1",
      path    => $steamcmd_path,
      timeout => 0,
    }
  } elsif $ensure == 'absent' {
    exec { "Removing ${title} via SteamCMD":
      command => "steamcmd.exe +login anonymous +app_uninstall ${app_id} +quit",
      unless  => "if exist \"%${install_dir}%\" exit 0",
      path    => $steamcmd_path,
    }
  }
}
