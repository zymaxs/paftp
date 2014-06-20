<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<link href="css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
</head>

<body>
<table border='1' width='100%'>
  <tr>
    <td colspan='3'>自动化实现</td>
    <td colspan='3'>优先级</td>
    <td colspan='3'>用例评审</td>
    <td colspan='2'>正反例</td>
  </tr>
  <tr>
    <td>已实现</td>
    <td>手动</td>
    <td>废弃</td>
    <td>P1</td>
    <td>P2</td>
    <td>P3</td>
    <td>待审批</td>
    <td>通过</td>
    <td>未通过</td>
    <td>正例</td>
    <td>反例</td>
  </tr>
  <tr>
    <td>0</td>
    <td>0</td>
    <td>1</td>
    <td>0</td>
    <td>0</td>
    <td>1</td>
    <td>1</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>1</td>
  </tr>
</table>
</body>
</html>