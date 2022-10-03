<% Option Explicit %>
<!--#include file="layouts/header.asp"-->
  <h1> Blog Pages: File System Object (FSO) - List folder and file</h1>
  <style>
    .main-content {}

.search-box {
  margin: 0;
  position: absolute;
  top: 50%;
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
}

.search-one {
  margin:20px;
  border-bottom: 2px dotted #eee;
  padding-bottom: 20px;
}

.search-url {
  font-size: 13px;
}


.search-field {
  width: 100%;
  padding: 10px 35px 10px 15px;
  border: none;
  border-radius: 100px;
  outline: none;
}

.search-button {
  position: absolute;
  top: 30px;
  right: -240px;
  background: transparent;
  border: none;
  outline: none;
  margin-left: -33px;
}

.search-button img {
  width: 20px;
  height: 20px;
  object-fit: cover;
}

.pagination {
  text-align: center;
}

.page-one {
  padding: 2px 5px;
  margin: 0 5px;
  border: 1px solid #eee;
}
.page-one.active {
  color: red;
}

.uk-navbar-container:not(.uk-navbar-transparent) {
  background: #ddd;
}
  </style>
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
  <main>
    <% afsdfa game asfasfasdf as asdf asdf%>
    <% afsdfa asfasdfasdf asfasfasdf as asdf asdf%>
    <% afsdfa asfasdfasdf asfasfasdf as asdf asdf%>
    <% afsdfa asfasdfasdf asfasfasdf as asdf asdf%> drives
    <p>site design is a part of the marketing strategy that you can use for game websit</p>
  </main>
If your game website design is spot-on, you will soon notice how</p>

<!--#include file="layouts/footer.asp"-->
