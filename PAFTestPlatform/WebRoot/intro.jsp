<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.paftp.entity.*,com.paftp.dto.*" errorPage=""%>
<!DOCTYPE HTML>
<html>
<head>
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
    $('#diagram').highcharts({
        chart: {
            backgroundColor: 'white',
            events: {
                load: function () {

                    // Draw the flow chart
                    var ren = this.renderer,
                        colors = Highcharts.getOptions().colors,
                        rightArrow = ['M', 0, 0, 'L', 100, 0, 'L', 95, 5, 'M', 100, 0, 'L', 95, -5],
                        leftArrow = ['M', 100, 0, 'L', 0, 0, 'L', 5, 5, 'M', 0, 0, 'L', 5, -5];



                    // Separator, client from service
                    ren.path(['M', 120, 40, 'L', 120, 350])
                        .attr({
                            'stroke-width': 2,
                            stroke: 'silver',
                            dashstyle: 'dash'
                        })
                        .add();

                    // Separator, CLI from service
                    ren.path(['M', 420, 40, 'L', 420, 250])
                        .attr({
                            'stroke-width': 2,
                            stroke: 'silver',
                            dashstyle: 'dash'
                        })
                        .add();

                    // Separator, WEB II
                    ren.path(['M', 20, 260, 'L', 450, 260])
                        .attr({
                            'stroke-width': 2,
                            stroke: 'silver',
                            dashstyle: 'dash'
                        })
                        .add();                    
                    
                    // Headers
                    ren.label('DMZ-WEB', 20, 40)
                        .css({
                            fontWeight: 'bold'
                        })
                        .add();
                    ren.label('SERVER FARM', 220, 40)
                        .css({
                            fontWeight: 'bold'
                        })
                        .add();
                    ren.label('DB', 460, 40)
                        .css({
                            fontWeight: 'bold'
                        })
                        .add();
                    ren.label('WEB II', 390, 300)
                        .css({
                            fontWeight: 'bold'
                        })
                        .add();
                    ren.label('办公网', 25, 300)
                        .css({
                            fontWeight: 'bold'
                        })
                        .add();                    
                    
                    
                    // MTP
                    ren.label('MTP', 30, 70)
                        .attr({
                            fill: colors[2],
                            stroke: 'white',
                            'stroke-width': 2,
                            padding: 5,
                            r: 5
                        })
                        .css({
                            color: 'white'
                        })
                        .add()
                        .shadow(true);
                    
                    ren.label('LBSE', 30, 100)
                        .attr({
                            fill: colors[2],
                            stroke: 'white',
                            'stroke-width': 2,
                            padding: 5,
                            r: 5
                        })
                        .css({
                            color: 'white'
                        })
                        .add()
                        .shadow(true);  
                    
                    ren.label('......', 30, 130)
                        .attr({
                            fill: colors[2],
                            stroke: 'white',
                            'stroke-width': 2,
                            padding: 5,
                            r: 5
                        })
                        .css({
                            color: 'white'
                        })
                        .add()
                        .shadow(true);                      

                    // Arrow from Test client to MTP
                    ren.path(leftArrow)
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[3]
                        })
                        .translate(95, 90)
                        .add();
                    
                    // Arrow from MTP to Test client
                    ren.path(rightArrow)
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[3]
                        })
                        .translate(95, 100)
                        .add();                    
                    
                    ren.label( 'Test request', 110, 70)
                        .css({
                            fontSize: '10px',
                            color: colors[3]
                        })
                        .add();
                    
                    ren.label('Response', 115, 100)
                        .css({
                            fontSize: '10px',
                            color: colors[3]
                        })
                        .add();                    

                    ren.label('Test Clients', 210, 82)
                        .attr({
                            r: 5,
                            width: 80,
                            fill: colors[5]
                        })
                        .css({
                            color: 'white',
                            fontWeight: 'bold'
                        })
                        .add();

                    // Arrow from Phantom JS to Batik
                    ren.path(['M', 250, 110, 'L', 250, 185, 'L', 245, 180, 'M', 250, 185, 'L', 255, 180])
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[5]
                        })
                        .add();
                    
                    ren.label('CI', 250, 110)
                        .css({
                            color: colors[5],
                            fontSize: '10px'
                        })
                        .add();

                    ren.label('CI & Execution Server', 210, 200)
                        .attr({
                            padding: 5,
                            r: 5,
                            width: 130,
                            fill: colors[5]
                        })
                        .css({
                            color: 'white',
                            fontWeight: 'bold'
                        })
                        .add();

                    // Arrow from Batik to SaaS client
                    ren.path(['M', 235, 185, 'L', 235, 155, 'C', 235, 130, 235, 130, 215, 130,
                              'L', 95, 130, 'L', 100, 125, 'M', 95, 130, 'L', 100, 135])
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[3]
                        })
                        .add();

                    // Arrow from Batik to SaaS client
                    ren.path(['M', 265, 185, 'L', 265, 155, 'C', 265, 130, 265, 130, 275, 130,
                              'L', 450, 130, 'L', 445, 125, 'M', 450, 130, 'L', 445, 135])
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[1]
                        })
                        .add();             
                   
                    ren.label('Query DB', 310, 130)
                        .css({
                            color: colors[1],
                            fontSize: '10px'
                        })
                        .add();                    
                    
                    ren.label('Execute Tests', 130, 130)
                        .css({
                            color: colors[3],
                            fontSize: '10px'
                        })
                        .add();

                    // Mail Service
                    ren.label('Mail Service', 10, 200)
                        .attr({
                            fill: colors[4],
                            stroke: 'white',
                            'stroke-width': 2,
                            padding: 5,
                            r: 5
                        })
                        .css({
                            color: 'white',
                            width: '100px'
                        })
                        .add()
                        .shadow(true);





                    // Arrow from CI server to mail Service
                    ren.path(leftArrow)
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[5]
                        })
                        .translate(95, 215)
                        .add();

                    ren.label('Shell', 120, 195)
                        .css({
                            color: colors[5],
                            fontSize: '10px'
                        })
                        .add();

                    // Script label
                    ren.label('Database', 450, 82)
                        .attr({
                            fill: colors[1],
                            stroke: 'white',
                            'stroke-width': 2,
                            padding: 5,
                            r: 5
                        })
                        .css({
                            color: 'white',
                            width: '100px'
                        })
                        .add()
                        .shadow(true);

                    // Arrow from Script to PhantomJS
                    ren.path(leftArrow)
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[1]
                        })
                        .translate(330, 90)
                        .add();

                    ren.label('DB result', 340, 70)
                        .css({
                            color: colors[1],
                            fontSize: '10px'
                        })
                        .add();

                    // Arrow from PhantomJS to Script
                    ren.path(rightArrow)
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[1]
                        })
                        .translate(330, 100)
                        .add();

                    ren.label('Query DB', 330, 100)
                        .css({
                            color: colors[1],
                            fontSize: '10px'
                        })
                        .add();

                    // Test Plateform
                    ren.label('Test Plateform', 220, 300)
                        .attr({
                            fill: colors[6],
                            stroke: 'white',
                            'stroke-width': 2,
                            padding: 5,
                            r: 5
                        })
                        .css({
                            color: 'white'
                        })
                        .add()
                        .shadow(true);

                    // Test results
                    ren.path(['M', 280, 225, 'L', 280, 290, 'L', 275, 285, 'M', 280, 290, 'L', 285, 285])
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[5]
                        })
                        .add();
                    
                    ren.label('Test results', 290, 235)
                        .css({
                            color: colors[5],
                            fontSize: '10px'
                        })
                        .add();                  

                    // Mail to 办公网
                    ren.path(['M', 40, 225, 'L', 40, 290, 'L', 35, 285, 'M', 40, 290, 'L', 45, 285])
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[4]
                        })
                        .add();
                    
                    ren.label('Mail', 45, 235)
                        .css({
                            color: colors[4],
                            fontSize: '10px'
                        })
                        .add();                      
 
                    // 办公网到WEB II
                    ren.path(rightArrow)
                        .attr({
                            'stroke-width': 2,
                            stroke: colors[6]
                        })
                        .translate(70, 310)
                        .add();                    
                    
                    ren.label( 'Browser', 75, 290)
                        .css({
                            fontSize: '10px',
                            color: colors[6]
                        })
                        .add();                    
                    
                }
            }
        },
        title: {
            text: '网络架构',
            style: {
                color: 'black'
            }
        }

    });
});
</script>

</head>

<body>
	<!-- Header -->
	<%@ include file="head.jsp"%>

	<div id="main-wrap">
		<div id="container">
			<div id="diagram" style="width: 600px; height: 350px; margin: 0 auto"></div>
		</div><!-- #container -->
	</div>


	<!-- Footer -->
	<%@ include file="foot.jsp"%>

</body>
</html>