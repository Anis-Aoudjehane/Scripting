$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ($testadmin -eq $false) {
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
exit $LASTEXITCODE
}

  $ipTitle = "HOST Info"
  $ipMsg = "Do you want to Get Host Info?"

      $ipYes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
           "It displays the IP CONFIGURATION of the computer"

      $ipNo = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
           "Exit"

$ipOptions = [System.Management.Automation.Host.ChoiceDescription[]]($ipYes, $ipNo)

$ipResult = $host.ui.PromptForChoice($ipTitle, $ipMsg, $ipOptions, 0) 

switch ($ipResult)
    {
        0 {
            $hostName= read-host "enter host name"
             Write-Host ""
             Write-Host "_______________________"
               Write-Host "Name Servers"
               nslookup $hostName
            
            
             $ping= ping $hostName
            
            
            Write-Host "_______________________"
            Write-Host "Ping Test"
            Write-Host ""
            $ping
            Write-Host "_______________________"
         
            Write-Host ""
            tracert $hostName
           
           
           }
        
        1 {exit}
    }
 
 
 
 pause