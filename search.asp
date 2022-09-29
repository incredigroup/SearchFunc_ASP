<!--#include file="./models/search.asp" -->
  <%
    Dim keyword
    keyword = Request.QueryString("keyword")

    Dim ignoreFile, ignoreFolder, table
    Dim connection, recordset, sql, connectionString
    Dim datas, seq
    Set datas = Server.CreateObject("Scripting.Dictionary")
    ignoreFile = "header.asp, footer,asp, search.asp, global.asa, connection.udl"
    ignoreFolder = "/css, /docs/pdf, /images, /files"
    table = "community"

    connectionString = Application("connectionString")
    Set connection = Server.CreateObject("ADODB.Connection")
    connection.ConnectionString = connectionString
    connection.Open()
    
    Set recordset = connection.Execute("select * from community where description like '%" & keyword &"%'")
    seq = 0
    Do While Not recordset.EOF
      seq = seq+1
      set data = New search
      data.Link = "community.asp"
      data.Title = recordset.Fields("title")
      data.Summary = recordset.Fields("summary")
      data.Description = recordset.Fields("description")
      datas.add seq, data
      recordset.MoveNext
    Loop 
    connection.Close()

    Set objFSO = CreateObject("Scripting.FileSystemObject")
    folderURL = Application("rootURL")

    folderSpec = Server.MapPath(folderURL&"/")
    Set fso2 = CreateObject("Scripting.FileSystemObject")
    Set objFolder = fso2.getFolder(folderSpec)

    Response.write objFolder.Path
    Set colFiles = objFolder.Files
    For Each objFile in colFiles
        Response.write objFile.Name   & "<br/>"
    Next

    ShowSubfolders objFolder

    Sub ShowSubFolders(Folder)
        For Each Subfolder in Folder.SubFolders
            Response.write Subfolder.Path
            Set objFolder = objFSO.getFolder(Subfolder.Path)
            Set colFiles = objFolder.Files
            For Each objFile in colFiles
                Response.write objFile.Name & "<br/>"
            Next
            ShowSubFolders Subfolder
        Next
    End Sub
    
  %>

<!--#include file="layouts/header.asp"-->
  <h1 class="uk-title">List of Results </h1>
  <div class="search-count">Your search for < <%= keyword %> > matched 100 records</div>
  <br/>
      <div class="container">
        <% For Each item in datas %> 
          <div class="search-one">
            <label class="search-title">
              <div class="search-url">http://localhost/search/<%= datas(item).Link%></div>
              <a href="<%= datas(item).Link %>"><%= datas(item).Title%></a>
            </label>
            <div class="search-one-content"><%= datas(item).Description%></div>
          </div>
        <% Next %>




        <div class="search-one">
          <label class="search-title">
            <div class="search-url">http://localhost/community.asp</div>
            <a href="community.asp">what is the classic ASP</a>
          </label>
          <div class="search-one-content">ASP (aka Classic ASP) was introduced in 1998 as Microsofts ... side scripting language. <b>Classic ASP</b> pages ha.........</div>
        </div>

        <div class="search-one">
          <label class="search-title">
            <div class="search-url">http://localhost/blog.asp</div>
            <a href="blog.asp">what is the classic ASP</a>
          </label>
          <div class="search-one-content">ASP (aka Classic ASP) was introduced in 1998 as Microsoft <b>Classic ASP</b> side scripting language..... Classic ASP pages ha.........</div>
        </div>

        <div class="search-one">
          <label class="search-title">
            <div class="search-url">http://localhost/blog.asp?keyword=asp</div>
            <a href="blog.asp">what is the classic ASP</a>
          </label>
          <div class="search-one-content">ASP (aka Classic ASP) was introduced in 1998 as Microsoft <b>Classic ASP</b> side scripting language..... Classic ASP pages ha.........</div>
        </div>
      </div>
<!--#include file="layouts/footer.asp"-->

