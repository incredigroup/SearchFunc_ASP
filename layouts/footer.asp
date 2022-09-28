      <footer>
        <div class="footer-page">
          <h3>This is footer page</h3>
        </div>
      </footer>
      </div>
    </div>
    <script language="VBScript">
      sub search
          response.redirect ("publipostage.asp")
      end sub  
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- UIkit JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.25/js/uikit.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.25/js/uikit-icons.min.js"></script>
    <script type="text/javascript">
      hljs.initHighlightingOnLoad();
    </script>
    <script>
      $("#search").keydown(function (e) {
        if (e.keyCode == 13) {
            window.location = "search.asp?keyword=" + $(this).val();
        }
    });
    </script>
  </body>
</html>
