<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
<% 
if (request.getAttribute("flag")==null){
request.getRequestDispatcher("${pageContext.request.contextPath}/getSpecialTestpassContent.action").forward(request,response);}
TestpassDto testpassDto = (TestpassDto)request.getAttribute("testpassdto");
List<TestsuiteDto> testsuitedtoes = (List<TestsuiteDto>)request.getAttribute("testsuitedtoes");
String testpass_id = testpassDto.getId().toString();
String env = testpassDto.getEnv();
String tspasssum = testpassDto.getPasscount().toString();
String tsfailsum = testpassDto.getFailcount().toString();
String tstotalsum = testpassDto.getTotal().toString();
float tspassrate = testpassDto.getPercentage()*100;
String exec_time = testpassDto.getCreatetime().toString();
String exec_st = testpassDto.getName().toString();
String categories = "";
String catefail = "";
String catepass = "";
String catetotal = "";
String url_path = "localhost:8080/PAFTestPlatform/";
int height = (testsuitedtoes.size()*80+100);
for (int i =0 ; i < testsuitedtoes.size(); i ++ ){
	categories += "'<a href=\"http://"+url_path +"tsdetail.jsp?testpass_id="+testpass_id+"&testsuite_id="+testsuitedtoes.get(i).getId()+"\">" + testsuitedtoes.get(i).getName()+"</a>'" + ",";
	catefail += testsuitedtoes.get(i).getFailcount() + ",";
	catepass += testsuitedtoes.get(i).getPasscount() + ",";
	catetotal += testsuitedtoes.get(i).getTotal() + ",";
	 
}
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>主页</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/frame.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<script type="text/javascript" src="JavaScript/jquery-1.11.1.js"></script>
<script type="text/javascript" src="JavaScript/bootstrap.min.js"></script>
<script type="text/javascript" src="js/highcharts.js"></script>
<script type="text/javascript" src="js/exporting.js"></script>
<script src="JavaScript/index/index.js"></script>
<script src="JavaScript/common/common.js"></script>
<script>
$(function () {
        $('#container').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: '<%=exec_time%>'
            },
            subtitle: {
                text: '<%=exec_st%>'
            },
            xAxis: {
                categories: [<%=categories%>],
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Case (number)',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                valueSuffix: ''
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -30,
                y: 0,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true
            },
            credits: {
                enabled: false
            },
            series: [{
                name: 'Fail',
                data: [<%=catefail%>]
            }, {
                name: 'Pass',
                data: [<%=catepass%>]
            }, {
                name: 'Total',
                data: [<%=catetotal%>]
            }]
        });
    });
</script> 
</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
		<div style="text-align:center">
    <table class="table table-bordered" align="center" style="width:60%; margin:auto">
      <tr>
        <td colspan='4'>测试环境<%=env%></td>
      </tr>
      <tr>
        <td >Total</td>
        <td >Pass</td>
        <td >Fail</td>
        <td >Pass Rate</td>
      </tr>
      <tr>
        <td><%=tstotalsum%></td>
        <td><%=tspasssum%></td>
        <td><%=tsfailsum%></td>
        <td><%=tspassrate%>%</td>
      </tr>
    </table>
    </div>
  <div id="container" style=" width:80%;height:<%=height%>px; margin:auto"></div>
		</div><!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>