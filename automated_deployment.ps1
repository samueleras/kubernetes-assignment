$ErrorActionPreference = "Stop"

Write-Output "Rolling out changes..."
kubectl rollout restart deployment kubernetes-assignment
Get-Job | Where-Object { $_.Command -match 'kubectl port-forward' } | Remove-Job -Force

Start-Sleep -Seconds 10

Start-Job -ScriptBlock { kubectl port-forward svc/kubernetes-assignment 8080:8080 }
Write-Output "Deployment successful!"