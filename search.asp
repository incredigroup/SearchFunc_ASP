
  <%
    Dim keyword
    keyword = Request.QueryString("keyword")
    Dim connection, recordset, sql, connectionString
    Dim datas

    connectionString = Application("connectionString")
    Set connection = Server.CreateObject("ADODB.Connection")
    
    connection.ConnectionString = connectionString
    connection.Open()
    
    Dim data, seq
    Set recordset = connection.Execute("select * from community where  title LIKE %" & keyword & "% and summary LIKE %" & keyword & "%")
    seq = 0
    Do While Not recordset.EOF
      seq = seq+1
      set data = New country
      data.Title = recordset.Fields("title")
      data.Code = recordset.Fields("summary")
      datas.add seq, data
      recordset.MoveNext
    Loop 
    connection.Close()

    fileName = Application("rootURL") & "/files/countries.txt"
    fileSpec = Server.MapPath(fileName)
    
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set file = fso.OpenTextFile(filespec,1) 

    Response.write "Reading file " & fileName & "<br/><br/>"
    Do While Not file.AtEndOfStream
      countrySplit = Split(file.ReadLine, ",")
      Response.write countrySplit(0) &": "& countrySplit(1) &"<br/>"
    Loop
  %>

<!--#include file="layouts/header.asp"-->
  <h1 class="uk-title">List of Results </h1>
  <div class="search-count">Your search for < <%= keyword %> > matched 100 records</div>
  <br/>
      <div class="container">
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

