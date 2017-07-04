define steamcmd (
  $ensure = 'present',
  $app_id,
) {
  if $ensure == 'present' {
    exec { "Installing ${title} via SteamCMD":
      command => "cmd.exe /c steamcmd +login anonymous +app_update ${app_id} +quit",
      unless  => "cmd.exe /c steamcmd +login anonymous +apps_installed +quit | findstr ${app_id}",
    }
  } elsif $ensure == 'absent' {
    exec { "Removing ${title} via SteamCMD":
      command => "cmd.exe /c steamcmd +login anonymous +app_uninstall ${app_id} +quit",
      unless  => "cmd.exe /c steamcmd +login anonymous +apps_installed +quit | findstr ${app_id}",
    }
  }
}
