<!--#include file="./models/search.asp" -->
<!--#include file="./models/jsonobj.asp" -->

  <%
    Dim keyword, page, curpage                                             'http parameters
    keyword = Request.QueryString("keyword")
    curpage = Request.QueryString("page")
    session("page") = Request.QueryString("page")

    Dim ignoreFile, ignoreFolder, regexObject                              'file and folder setting variable
    Dim connection, recordset, sql, connectionString                       'database connection variable
    Dim datas, seq, cnt, query                                             ' database variables
    Dim requestedPage, MAX_PAGE, perPage, sItem, eItem                     'pagination variables

    Set oJSON = New aspJSON
    folderURL = Application("rootURL")
    Set datas = Server.CreateObject("Scripting.Dictionary")
    
    perPage = 5                                                              ' number per page
    ignoreFile = array("header.asp", "README.md", "footer.asp", "search.asp", "global.asa", "connection.udl", "LICENSE")
    ignoreFolder = array("/css", "/docs/pdf", "/images", "/files", "/.git", "/models")

		tableString = "{tableSetting: [{ ""table"" : ""community"", ""link"": ""community.asp"", ""columns"": [""summary"", ""title"", ""description""]}, "
    tableString = tableString & "{ ""table"" : ""blog"", ""link"": ""blog.asp"", ""columns"": [""title"", ""description""]}] }"
    

' /////////////////////////////////////////////                Get search query using union         ///////////////////////////////////
    oJSON.loadJSON(tableString)
    j = 1
    For Each table In oJSON.data("tableSetting")
        Set this = oJSON.data("tableSetting").item(table)
        tablename = this.item("table")
        link = this.item("link")
        columns = ""
        concat = ""
        i = 1
        For Each one in this.item("columns")
          If i = this.item("columns").Count Then 
            columns = columns & this.item("columns").item(one) & " like '%" & keyword & "%'"
          Else 
            columns = columns & this.item("columns").item(one) & " like '%" & keyword & "%' and "
          End If
          IF i = 1 Then concat = this.item("columns").item(one) Else concat = concat & "," & this.item("columns").item(one)  End If
          i = i + 1
        Next
        If j = 1 Then 
          query = " select concat(" & concat & ") as description, '" & link & "' as link  from " & tablename & " where " & columns
        Else
          query = query & " UNION " & " select concat(" & concat & ") as description, '" & link & "' as link  from " & tablename & " where " & columns
        End If
        j = j + 1
    Next

    Dim ignoreFile_obj : Set ignoreFile_obj = Server.CreateObject("Scripting.Dictionary")
    ignoreFile_obj.CompareMode = vbTextCompare
    For Each i In ignoreFile
        ignoreFile_obj(i) = i
    Next
    Dim ignoreFolder_obj : Set ignoreFolder_obj = Server.CreateObject("Scripting.Dictionary")
    ignoreFolder_obj.CompareMode = vbTextCompare
    For Each i In ignoreFolder
      ignoreFolder_obj(Replace(Server.MapPath(folderURL&i), "\", "")) = Server.MapPath(folderURL&i)
    Next

'////////////////////////////////  strip html tags and comments in files ///////////////////////// 
    Set regexObject = CreateObject("vbscript.regexp")
    With regexObject
        .Pattern = "<!*[^<>]*>"
        .Global = True
        .IgnoreCase = True
        .MultiLine = True
    End With 


' /////////////////////////////   Search from Database       ////////////////////////////////////////////
    connectionString = Application("connectionString")
    Set connection = Server.CreateObject("ADODB.Connection")
    connection.ConnectionString = connectionString
    connection.Open()
    Set recordset = connection.Execute(query)
    seq = 0
    cnt = 0
    Do While Not recordset.EOF
      fileContent = recordset.Fields("description")
      searchPosition = InStr(1,fileContent, keyword, 1)
      IF searchPosition <> 0 Then
        getSearchContent fileContent, searchPosition, recordset.Fields("link")
      End IF
      recordset.MoveNext
    Loop 
    connection.Close()


' //////////////////////////////////////////      Search  from file     /////////////////////////////////
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    folderSpec = Server.MapPath(folderURL&"/")
    Set fso2 = CreateObject("Scripting.FileSystemObject")
    Set objFolder = fso2.getFolder(folderSpec)
    Set colFiles = objFolder.Files
    For Each objFile in colFiles
        If ignoreFile_obj.Exists(objFile.Name) = 0 Then
          Set fso = CreateObject("Scripting.FileSystemObject")
          Set file = fso.OpenTextFile(objFile.Path,1) 
          ' Do While Not file.AtEndOfStream
            fileContent = file.ReadAll
            searchPosition = InStr(1,fileContent, keyword, 1)
            IF searchPosition <> 0 Then
              getSearchContent fileContent, searchPosition, objFile.Name
            End IF
          ' Loop
        End If
    Next

    ShowSubfolders objFolder
    Sub ShowSubFolders(Folder)
      If ignoreFolder_obj.Exists(Replace(Folder, "\", "")) = 0 then
        ' Response.write "subfolder" & Folder & "<br/><br/>"
        For Each Subfolder in Folder.SubFolders
          Set mobjFolder = objFSO.getFolder(Subfolder.Path)
          Set ncolFiles = mobjFolder.Files
          For Each nobjFile in ncolFiles
              If ignoreFile_obj.Exists(nobjFile.Name) = 0 Then
                Set fso = CreateObject("Scripting.FileSystemObject")
                Set file = fso.OpenTextFile(nobjFile.Path,1) 
                  fileContent = file.ReadAll
                  searchPosition = InStr(1,fileContent, keyword, 1)
                  IF searchPosition <> 0 Then
                    getSearchContent fileContent, searchPosition, nobjFile.Name
                    ' Response.write nobjFile.Name
                  End IF
              End If
          Next
          ShowSubFolders Subfolder
        Next
      End If
    End Sub

    Sub getSearchContent(fileContent, searchPosition, link)
      cnt = cnt + 1
      searchPosition = searchPosition - 200 
      If searchPosition <= 0 Then searchPosition = 1 End If 
      fileContent = regexObject.Replace(fileContent, "")
      fileContent = Replace(fileContent, keyword, "<b>"&keyword&"</b>", 1, -1, 1)
      seq = seq + 1
      set data = New search
      data.Link = link
      data.Description =  "..." & Mid(fileContent, searchPosition, 500) & "..."
      datas.add seq, data
    End Sub

' //////////////////////////////////////////             Pagination Code                    //////////////////////////////
      
      sItem = 1
      requestedPage = LCase(Request("page"))
      MAX_PAGE = Ceil(datas.Count / perPage)
      If ( MAX_PAGE > 1 ) And ( CurrentPage() > 1 ) Then 
        sItem = (CurrentPage()-1) * perPage + 1
      End If
      eItem = sItem + 4
      If eItem > datas.Count Then eItem = datas.Count End If 
      
      If requestedPage = "next" Then
        page = NextPage()
      ElseIf requestedPage = "prev" Then
        page = PrevPage()
      Else
        page = SetPage(requestedPage)
      End If


      Function CurrentPage
          If IsNumeric(Session("page")) Then
              CurrentPage = Session("page")
          Else
              CurrentPage = 1
          End If 
      End Function

      Function NextPage
          NextPage = SetPage(CurrentPage() + 1)
      End Function

      Function PrevPage
          PrevPage = SetPage(CurrentPage() - 1)
      End Function

      Function SetPage(newPage)
          If Not IsNumeric(newPage) Then
              Session("page") = 1
          ElseIf page < 1 Then
              Session("page") = 1
          ElseIf page > MAX_PAGE Then
              Session("page") = MAX_PAGE
          Else
              Session("page") = Int(newPage)
          End If
          SetPage = Session("page")
      End Function
      Function Ceil(p_Number)
          Ceil = 0 - INT( 0 - p_Number)
      End Function
%>


<!--#include file="layouts/header.asp"-->
  <h1 class="uk-title">List of Results </h1>
  <% If MAX_PAGE <> 0 Then%>
  <div class="search-count">Your search for < <%= keyword %> > matched <%= cnt %> records</div>
  <br/>
    <div class="container">
        <% For item = sItem to  eItem  Step 1 %> 
          <div class="search-one">
            <label class="search-title">
              <a href="<%= datas(item).Link %>">http://localhost/search/<%= datas(item).Link %></a>
            </label>
            <div class="search-one-content"><%= datas(item).Description%></div>
          </div>
        <% Next %>
    </div>
    <div class="pagination">
      <a href="search.asp?page=prev&keyword=<%= keyword%>">Previous </a>
      <% For i = 1 to MAX_PAGE Step 1 %>
        <%If i = curpage * 1 Then %>
          <a class="page-one" href="search.asp?page=<%= i%>&keyword=<%= keyword%>"><%= i%></a>
        <%Else%>
          <a class="page-one active" href="search.asp?page=<%= i%>&keyword=<%= keyword%>"><%= i%></a>
        <%End If%>
      <% Next %>
      <a href="search.asp?page=next&keyword=<%= keyword%>">Next</a> 
    </div>
  <%Else%>
    <div class="search-count">There is no Results</div>
  <% End If%>
  
<!--#include file="layouts/footer.asp"-->
