<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.treeview.js"></script>
<title>无标题文档</title>
<script type="text/javascript">

$(document).ready(function(){
 
 $("#navigation").treeview({
  persist: "location",
  collapsed: true,
  unique: true
 });

});

</script>
</head>

<body>
<ul id="navigation">
  <li><a href="?1">Item 1</a>
    <ul>
      <li><a href="?1.0">Item 1.0</a>
        <ul>
          <li><a href="?1.0.0">Item 1.0.0</a></li>
        </ul>
      </li>
      <li><a href="?1.1">Item 1.1</a></li>
      <li><a href="?1.2">Item 1.2</a>
        <ul>
          <li><a href="?1.2.0">Item 1.2.0</a>
            <ul>
              <li><a href="?1.2.0.0">Item 1.2.0.0</a></li>
              <li><a href="?1.2.0.1">Item 1.2.0.1</a></li>
              <li><a href="?1.2.0.2">Item 1.2.0.2</a></li>
            </ul>
          </li>
          <li><a href="?1.2.1">Item 1.2.1</a>
            <ul>
              <li><a href="?1.2.1.0">Item 1.2.1.0</a></li>
            </ul>
          </li>
          <li><a href="?1.2.2">Item 1.2.2</a>
            <ul>
              <li><a href="?1.2.2.0">Item 1.2.2.0</a></li>
              <li><a href="?1.2.2.1">Item 1.2.2.1</a></li>
              <li><a href="?1.2.2.2">Item 1.2.2.2</a></li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
  </li>
  <li><a href="?2">Item 2</a>
    <ul>
      <li><span>Item 2.0</span>
        <ul>
          <li><a href="?2.0.0">Item 2.0.0</a>
            <ul>
              <li><a href="?2.0.0.0">Item 2.0.0.0</a></li>
              <li><a href="?2.0.0.1">Item 2.0.0.1</a></li>
            </ul>
          </li>
        </ul>
      </li>
      <li><a href="?2.1">Item 2.1</a>
        <ul>
          <li><a href="?2.1.0">Item 2.1.0</a>
            <ul>
              <li><a href="?2.1.0.0">Item 2.1.0.0</a></li>
            </ul>
          </li>
          <li><a href="?2.1.1">Item 2.1.1</a>
            <ul>
              <li><a href="?2.1.1.0abc">Item 2.1.1.0</a></li>
              <li><a href="?2.1.1.1">Item 2.1.1.1</a></li>
              <li><a href="?2.1.1.2">Item 2.1.1.2</a></li>
            </ul>
          </li>
          <li><a href="?2.1.2">Item 2.1.2</a>
            <ul>
              <li><a href="?2.1.2.0">Item 2.1.2.0</a></li>
              <li><a href="?2.1.2.1">Item 2.1.2.1</a></li>
              <li><a href="?2.1.2.2">Item 2.1.2.2</a></li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
  </li>
  <li><a href="?3">Item 3</a>
    <ul>
      <li class="open"><a href="?3.0">Item 3.0</a>
        <ul>
          <li><a href="?3.0.0">Item 3.0.0</a></li>
          <li><a href="?3.0.1">Item 3.0.1</a>
            <ul>
              <li><a href="?3.0.1.0">Item 3.0.1.0</a></li>
              <li><a href="?3.0.1.1">Item 3.0.1.1</a></li>
            </ul>
          </li>
          <li><a href="?3.0.2">Item 3.0.2</a>
            <ul>
              <li><a href="?3.0.2.0">Item 3.0.2.0</a></li>
              <li><a href="?3.0.2.1">Item 3.0.2.1</a></li>
              <li><a href="?3.0.2.2">Item 3.0.2.2</a></li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
  </li>
</ul>
</body>
</html>