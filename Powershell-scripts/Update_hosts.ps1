$envs = 'test1-cms', 'sit1'
$filepath = "$($env:windir)\system32\Drivers\etc\hosts"

foreach ($env in $envs)
{
    $addr = "cc-services-mocks.$env.gb.msm.internal"
    
    $ip = Resolve-DnsName -Name "services.$env.gb.moneysupermarket.com" -NoHostsFile |
    Where-Object -Property Address|    
    Select-Object -ExpandProperty Address -First 1
    
    $line = Select-String -SimpleMatch "cc-services-mocks.$env.gb.msm.internal" -Path $filepath

    if ($line) 
    {
        $newContent = Get-Content $filepath |
        ForEach-Object {
            $_ -replace "^.+$addr", "$ip $addr"
        }
        
        [System.IO.File]::WriteAllLines($filepath, $newContent, [System.Text.Encoding]::ASCII)
    }
    else
    {
        Add-Content -Value "$ip $addr" -Path $filepath -Encoding Ascii
    }
}