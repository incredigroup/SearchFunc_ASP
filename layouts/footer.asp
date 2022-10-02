      <footer>
        <div class="footer-page">
          <h3>This is footer page</h3>
        </div>
      </footer>
      </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- UIkit JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.25/js/uikit.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.25/js/uikit-icons.min.js"></script>
    <script type="text/javascript">
      hljs.initHighlightingOnLoad();
    </script>
    <script>
      $("#keyword").keydown(function (e) {
        if (e.keyCode == 13) {
            if($(this).val()) {
              window.location = "search.asp?keyword=" + $(this).val() + "&page=1";
            } else {
              alert("Nothing to Search!");
              return;
            }
        }
      });

      $(".search-button").click(function (){
        if($("#keyword").val()) {
            window.location = "search.asp?keyword=" + $("#keyword").val() + "&page=1";
        } else {
          alert("Nothing to Search!");
          return;
        }
      })
    </script>
  </body>
</html>
