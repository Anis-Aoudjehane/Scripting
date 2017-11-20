$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ($testadmin -eq $false) {
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
exit $LASTEXITCODE
}

  Write-Host ""
             Write-Host "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
             Write-Host ""
             Write-Host "This Script displays domain name and ip addresses informations"
             Write-Host "                          @Anis.A                             "
             Write-Host ""
             Write-Host "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
             Write-Host ""
             Write-Host ""

      $ipTitle = "HOST Info"
      $ipMsg = "Do you want to Get Host Info?"

      $ipYes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
           "It displays the IP CONFIGURATION of the computer"

      $ipNo = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
           "Exit"

      $ipOptions = [System.Management.Automation.Host.ChoiceDescription[]]($ipYes, $ipNo)

      $ipResult = $host.ui.PromptForChoice($ipTitle, $ipMsg, $ipOptions, 0) 

             switch ($ipResult) {
       
                    0 {
            
                          Write-Host ""
                          Write-Host "..........................."
                          $hostName= read-host "Enter Host Name"
                          Write-Host "..........................."
                          Write-Host ""
                          Write-Host "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
                          Write-Host ""
                          Write-Host "Name Servers"
                          nslookup $hostName
                          nslookup -queytype=soa $hostName
                          Write-Host ""
                          Write-Host "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
                          Write-Host ""
                          Write-Host "Ping Test"
                          Write-Host ""
            
                          $ping= ping $hostName
                          $ping
                          Write-Host ""
                          Write-Host "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
                     } #End of Option 0
        
                   1 {exit} #End of Option 1
             } #End of Option 1


      $traceTitle = "TRACEROUTE"
      $traceMsg = "Do you want to run Traceroute?"

      $traceYes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
           "Start a traceroute to the server"

      $traceNo = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
           "Exit"

      $traceOptions = [System.Management.Automation.Host.ChoiceDescription[]]($traceYes, $traceNo)

      $traceResult = $host.ui.PromptForChoice($traceTitle, $traceMsg, $traceOptions, 0) 

             switch ($traceResult) {
        
                    0 {tracert $hostName}
           
                    1 {break}
             }

      Write-Host ""
      Write-Host "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
      Write-Host ""
      $portTitle = "Port Scanning"
      Write-Host ""
      $portMsg = "Do you want to check if ports are open?"

      $portYes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
           "Start a traceroute to the server"

      $portNo = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
           "Exit"

      $portOptions = [System.Management.Automation.Host.ChoiceDescription[]]($portYes, $portNo)

      $portResult = $host.ui.PromptForChoice($portTitle, $portMsg, $portOptions, 0) 

             switch ($portResult) {
        
                     0 {          
            
                            $pTitle = ""
                            Write-Host ""
                            Write-Host "What type of scan do you want to perform?"
                            Write-Host "             1. Common Ports (80,443,21,22,25,53,139,143,110,113)"
                            Write-Host "             2. Specific Port"
                            $pMsg = ""
                            
                            $p1 = New-Object System.Management.Automation.Host.ChoiceDescription "&1", `
                              "Scan only common ports"

                            $p2 = New-Object System.Management.Automation.Host.ChoiceDescription "&2", `
                              "Enter the port you want to Scan"

                            $pOptions = [System.Management.Automation.Host.ChoiceDescription[]]($p1, $p2)

                            $pResult = $host.ui.PromptForChoice($pTitle, $pMsg, $pOptions, 0) 
                         

                                  switch ($pResult) {
                                           
                                          0 { 
                                                    Test-NetConnection -Port 80 -ComputerName $hostName
                                                    Test-NetConnection -Port 443 -ComputerName $hostName
                                                    Test-NetConnection -Port 21 -ComputerName $hostName
                                                    Test-NetConnection -Port 22 -ComputerName $hostName
                                                    Test-NetConnection -Port 23 -ComputerName $hostName
                                                    Test-NetConnection -Port 25 -ComputerName $hostName
                                                    Test-NetConnection -Port 53 -ComputerName $hostName
                                                    Test-NetConnection -Port 139 -ComputerName $hostName
                                                    Test-NetConnection -Port 143 -ComputerName $hostName
                                                    Test-NetConnection -Port 110 -ComputerName $hostName
                                                    Test-NetConnection -Port 113 -ComputerName $hostName
                                             } #End Of Option 0 
           
       
                                           1 {     

                                                 
                                                  $portEdit =0
                                                  $portEdit= read-host "Enter the port number"
                                                 
                                                  While ($portEdit -ne "x"){

                                                    Write-Host ""
                                                    Test-NetConnection -Port $portEdit -ComputerName $hostName
                                                    ""
                                                    "Enter x to cancel"
                                                    ""
                                                    $portEdit= read-host "Enter the port number"
                                                   

                                                   } #End Of While
        
                                              } #End Of Option 1
                                  } #End Of Inner Switch
   
                        } #End Of outer Option 0 

           
                      1 {break} #End Of outer Option 1
             } #End Of Global Switch

 
 
 pause
