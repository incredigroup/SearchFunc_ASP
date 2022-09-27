# How to run

    https://edi.wang/post/2019/7/17/run-classic-asp-on-windows-10-and-azure-app-service

   1: run: appwiz.cpl
      select asp under Windows features/Internet Information features
      <img src="1">
   2: Go to the Application Pools and create a new application pool just for ASP environment named Classic ASP
      Set .NET CLR Version to No Managed Code. This is because ASP is not executed by .NET, there is no need for CLR to exist. 
      <img src="2">
      Set Managed pipleline mode to Classic. (Optional, but it's more ASPish way to make IIS more "decouple" with ASP.NET pipeline).
      and so on.


# Learn Classic ASP 
