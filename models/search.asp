<% 
  Class Search
    'Private, class member variable
    Private p_seq
    Private p_link
    Private p_title
    Private p_summary
    Private p_description

    ' getter and setter
    Public Property Get Title()
      Title = p_title
    End Property
    Public Property Let Title(value)
      p_title = value
    End Property

    Public Property Get Link()
      Link = p_link
    End Property
    Public Property Let Link(value)
      p_link = value
    End Property
    
    Public Property Get Summary()
      Summary = p_summary
    End Property
    Public Property Let Summary(value)
      p_summary = value
    End Property

    Public Property Get Description()
      Description = p_description
    End Property
    Public Property Let Description(value)
      p_description = value
    End Property
    
  End Class
%>
