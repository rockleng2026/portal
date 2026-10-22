
function showgraph(data){
    // first we generate some random data
    //alert(222);
    generateChartData(data);
    //generateChartDataDemo();

    // SERIAL CHART
    chart = new AmCharts.AmSerialChart();
    chart.pathToImages = "litscloud/flowchart/images/";
    chart.zoomOutButton = {
        backgroundColor: '#000000',
        backgroundAlpha: 0.15
    };
    chart.dataProvider = chartData;
    chart.categoryField = "date";

    // data updated event will be fired when chart is first displayed,
    // also when data will be updated. We'll use it to set some
    // initial zoom
    chart.addListener("dataUpdated", zoomChart);//设置监听

    // AXES 轴
    // Category 类别
    var categoryAxis = chart.categoryAxis;//得到类别轴(X轴)
    categoryAxis.parseDates = true; // in order char to understand dates, we should set parseDates to true 设置对时间字符串进行解析
    categoryAxis.minPeriod = "mm"; // as we have data with minute interval, we have to set "mm" here.样例以分钟为时间间隔所以设置为mm格式			 
    categoryAxis.gridAlpha = 0.07;//设置网格的Alpha值
    categoryAxis.axisColor = "#0d4ef2";//X轴颜色

    // Value 定义Y轴
    var valueAxis = new AmCharts.ValueAxis();//得到数值轴(Y轴)
    valueAxis.gridAlpha = 0.07;//
    valueAxis.title = "CDN Flow Chart";//左边标识字符串
    chart.addValueAxis(valueAxis);//将chart的Y轴对象关联到此Y轴对象

    // GRAPH 定义图表
    var graph = new AmCharts.AmGraph();
    graph.type = "line"; // try to change it to "column" 设置图表的类型为线性 column 为柱状图
    graph.title = "red line";//图表标题
    graph.valueField = "visits";//设置Y轴的字段属性名称
    graph.lineAlpha = 1;
    graph.lineColor = "#0df223";//图表线的颜色
    graph.fillAlphas = 0.3; // setting fillAlphas to > 0 value makes it area graph 设置填充区域的颜色系数0-1之间 0没有 1和线的颜色一致
    chart.addGraph(graph);//关联图表

    // CURSOR 定义光标
    var chartCursor = new AmCharts.ChartCursor();
    chartCursor.cursorPosition = "mouse"; //设置光标位置为鼠标垫
    chartCursor.categoryBalloonDateFormat = "JJ:NN, DD MMMM";//设置X轴显示的时间格式
    chart.addChartCursor(chartCursor);

    // SCROLLBAR
    var chartScrollbar = new AmCharts.ChartScrollbar();

    chart.addChartScrollbar(chartScrollbar);

    // WRITE
    chart.write("chartdiv");//内容写入层中显示出来

}
        

    // generate some random data, quite different range 
   function generateChartData(data) {
	  //alert(data);
       var str = data.split(",");
       //alert(str.length);
       var num = str.length;
       for (var i = 0; i < num ; i++) {
       	var log =str[i].split(":");
           var newDate = new Date(parseInt(log[0]));
           var visits = log[1];//Y值必须为数字类型 否则解析出错
           //alert(log[0]+"--"+log[1]);
           //alert(newDate+"--"+visits);
           // add data item to the array                          
           chartData.push({
               date: newDate,
               visits: visits
           });
       }
   }
  function generateChartDataDemo() {
     // current date
     var firstDate = new Date();
    // alert(firstDate.getDate());
    // alert(firstDate.getTime());
    // alert(Math.random());
     // now set 1000 minutes back                 
     firstDate.setHours(firstDate.getHours() - 10);

     // and generate 1000 data items
     for (var i = 0; i < 10; i++) {
         var newDate = new Date(firstDate);
         // each time we add one minute
         newDate.setMinutes(newDate.getMinutes() + i);
         // some random number      
         var visits = Math.round(Math.random() * 40) + 10;
         //alert(newDate+"--"+visits);
         // add data item to the array                          
         chartData.push({
             date: newDate,
             visits: visits
         });
     }
 }

   // this method is called when chart is first inited as we listen for "dataUpdated" event
   function zoomChart() {
       // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
       chart.zoomToIndexes(chartData.length - 40, chartData.length - 1);
   }
   /**
    * 
    * @param str YYYY-MM-DD 
    * @return
    */
   function CheckDateTime(str)  
   {   
       //alert(1111)
	   var reg = /^(\d+)-(\d{1,2})-(\d{1,2})$/;   
       var r = str.match(reg);
       if(r==null)return false;
       r[2]=r[2]-1;
       var d= new Date(r[1],r[2],r[3]);
       if(d.getFullYear()!=r[1])return false; 
       //alert(222);
       if(d.getMonth()!=r[2])return false; 
       //alert(333);
       if(d.getDate()!=r[3])return false;
       return true;   
   } 