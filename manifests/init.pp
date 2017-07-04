define steamcmd (
  $ensure = 'present',
  $app_id,
  $steamcmd_path = 'C:/programdata/chocolatey/bin/',
) {
  if $ensure == 'present' {
    exec { "Installing ${title} via SteamCMD":
      command => "steamcmd.exe +login anonymous +app_update ${app_id} +quit",
      unless  => "steamcmd.exe +login anonymous +apps_installed +quit | findstr ${app_id}",
      path    => $steamcmd_path,
      timeout => 0,
    }
  } elsif $ensure == 'absent' {
    exec { "Removing ${title} via SteamCMD":
      command => "steamcmd.exe +login anonymous +app_uninstall ${app_id} +quit",
      unless  => "steamcmd.exe +login anonymous +apps_installed +quit | findstr ${app_id}",
      path    => $steamcmd_path,
    }
  }
}
