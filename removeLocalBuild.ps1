$propertiesExist = Test-Path localDevDeploy.properties
$ErrorActionPreference = "Stop"

if ($propertiesExist -eq $true) {
    Write-Host ""
    Write-Host "Reading localDevDeploy.properties"
    Write-Host ""

    # Build the settings we will work with
    $properties = Get-Content localDevDeploy.properties
    $settings = @{""=""};
    foreach ($line in $properties) {
        $items = $line.Split("=")
        $settings.Add($items[0], $items[1])
    }

    # Ensure we know what things to operate on
    if($settings.ContainsKey("arma3Install") -eq $true -and $settings.ContainsKey("pboManagerInstall") -eq $true) {
        # Set the dev file name that we'll be using everywhere
        $devFileName = "DUWS-R_dev.Altis.pbo"

        # Pull other 'real' release out by renaming them to .bak
        $tmp = $settings["arma3Install"] + "\Missions\"
        $oldExists = Test-Path "$tmp$devFileName"
        if($oldExists -eq $true) {
            Remove-Item "$tmp$devFileName"
        }
        $otherFiles = Get-ChildItem $tmp -filter "DUWS-R_*.pbo.bak"
        foreach ($file in $otherFiles){
            $lenOfName = $("$tmp$file").length
            Rename-Item "$tmp$file" $("$tmp$file").substring(0, $lenOfName-3)
        }

        # Pull other 'real' release out by renaming them to .bak
        $tmp = $settings["arma3Install"] + "\MPMissions\"
        $oldExists = Test-Path "$tmp$devFileName"
        if($oldExists -eq $true) {
            Remove-Item "$tmp$devFileName"
        }
        $otherFiles = Get-ChildItem $tmp -filter "DUWS-R_*.pbo.bak"
        foreach ($file in $otherFiles){
            $lenOfName = $("$tmp$file").length
            Rename-Item "$tmp$file" $("$tmp$file").substring(0, $lenOfName-3)
        }

    } else {
        Write-Host "could not find arma3Install and pboManagerInstall keys in properties file"
    }

    Write-Host ""
} else {
    Write-Host ""
    Write-Host "Cannot find localDevDeploy.properties. Please create and configure the file then try again."
    Write-Host ""
}