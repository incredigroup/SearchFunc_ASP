<% Option Explicit %>
<!--#include file="layouts/header.asp"-->
  <h1> Blog Pages: File System Object (FSO) - List folder and file</h1>
  <%
    ' reference http://html.net/tutorials/asp/lesson14.asp
    ' anything related to CreateObject should use "Set" to set the variable

    ' read all disk drive directory in PC
    Dim fso, dir, drives
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set drives = fso.Drives

    Response.Write "Read Drive Letter"
    For Each dir in drives
      Response.Write dir.DriveLetter & "<br/>"
    Next
  %>
  <p>Proper gaming website design is a part of the marketing strategy that you can use for game website promoting your video game. Your potential users make their first impression about the game through your website and decide if they will give it a try. Your existing players have a chance to find out about some juicy features that may not be initially apparent in the game. This will keep them engaged longer.

If your game website design is spot-on, you will soon notice how</p>

<!--#include file="layouts/footer.asp"-->
