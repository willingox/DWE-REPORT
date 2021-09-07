<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 判断页面有效性-->
<%
	Object uName = session.getAttribute("user");
	//判断用户是否登录
	if (uName == null) {
		//	session.setAttribute("errMsg", "你还没登录，请登录...");
		//重定向到登录页面
		//	response.sendRedirect("login");
	}
%>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">
<title>运行数据查询(统计信息)</title>
<link rel="stylesheet" type="text/css"
	href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/e3.css" />
<link rel="stylesheet" type="text/css" href="css/default.css" />
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/echarts.min.js"></script>
</head>
<body>
	开始时间&nbsp;
	<input type="text" id="hsiStartTime" class="Wdate"
		onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
		data-options="required:true,editable:false"
		style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
	结束时间&nbsp;
	<input type="text" id="hsiEndTime" class="Wdate"
		onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28 23:59:59'})"
		data-options="required:true,editable:false"
		style="width: 160px; height: 22px;">&nbsp;&nbsp;
	<button id="hsi2" type="button" class="easyui-linkbutton"
		iconCls="icon-zoom-in">选择指标</button>
	&nbsp;&nbsp;
	<button id="csv" type="button" onclick="hsiExporterExcel()"
		class="easyui-linkbutton" iconCls="icon-save">导出CSV</button>
	<!-- 选择指标弹出框 -->
	<div id="hsi1"
		style="position: absolute;left: 400px;top: 80px;display:none;z-index: 9999;">
		<div id="title"
			style="width: 500px;height: 19px;background: #5B8BD9;border-top-left-radius: 10px;border-top-right-radius: 10px;">
			<div id="hsiimg"
				style="float: right;width: 39px;height: 19px;text-align: center;cursor:pointer;">
				<img id="hsichg" src="image/close.png"
					style="width: 30px;height: 19px;text-align: center;">
			</div>
		</div>
		<div
			style="width: 500px;height: 520px;background-color: #ecf3fa;border-bottom-left-radius: 10px;border-bottom-right-radius: 10px;">
			<div style="padding:10px 0 0 20px;">
				风机&nbsp; <select id="hsifanlist">
				</select>
			</div>
			<div style="width: 500px;height: 260px;margin-top:10px;">
				<div style="width: 185px;height: 260px;margin-left:20px;float:left;">
					<select multiple="multiple" style="width: 185px;height: 260px;"
						id="hsilistleft">
					</select>
				</div>
				<div
					style="width: 65px;height: 230px;padding:30px 0 0 22px;float:left;">
					<p>
						<button id="hsiSelectOneToRight" type="button"
							style="width:50px;height:35px;" class="easyui-linkbutton"
							iconCls="icon-right-bold"></button>
					</p>
					<p>
						<button id="hsiSelectAllToRight" type="button"
							style="width:50px;height:35px;" class="easyui-linkbutton"
							iconCls="icon-double-right"></button>
					</p>
					<p>
						<button id="hsiSelectOneToLeft" type="button"
							style="width:50px;height:35px;" class="easyui-linkbutton"
							iconCls="icon-left-bold"></button>
					</p>
					<p>
						<button id="hsiSelectAllToLeft" type="button"
							style="width:50px;height:35px;" class="easyui-linkbutton"
							iconCls="icon-double-left"></button>
					</p>
				</div>
				<div
					style="width: 185px;height: 260px;margin-right:20px;float:right;">
					<select multiple="multiple" style="width: 185px;height: 260px;"
						id="hsilistright">
					</select>
				</div>
			</div>
			<div style="width: 460px;height: 160px;margin:10px 0 0 20px;">
				<span>已选择风机的指标：</span>
				<div>
					<select multiple="multiple" style="width: 457px;height: 138px;"
						id="hsilistall">
					</select>
				</div>
			</div>
			<div style="width: 500px;height: 30px;text-align: center;">
				<button id="ok" type="button"
					onclick="javascript:hsiReturnCurrentNode()"
					class="easyui-linkbutton" iconCls="icon-ok">确&nbsp;&nbsp;定</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button id="cancel" type="button"
					onclick="javascript:hsiReturnClose()" class="easyui-linkbutton"
					iconCls="icon-cancel">取&nbsp;&nbsp;消</button>
			</div>
		</div>
	</div>
	
	<div id="hsimain" style="width: 100%; height: 400px;"></div>
	<div style="width: 100%">
		<table class="easyui-datagrid" id="hisStatisticalInfoList"
			title="统计信息列表" style="width: auto;"
			data-options="singleSelect:false,fitColumns:true,striped:true,method:'get'">
			<thead>
				<tr>
					<th data-options="field:'savetime',width:60">时间</th>
				</tr>
			</thead>
		</table>
	</div>

	<script type="text/javascript">
		function hsiJSONToCSVConvertor(JSONData, ReportTitle, ShowLabel, removeLabel) {
			//如果JSONData不是对象，那么JSON。parse将解析对象中的JSON字符串
			var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData)
				: JSONData;
			var CSV = '';
			//在第一行或第一行设置报表标题
			CSV += ReportTitle + '\r\n\n';
			//此条件将生成标签/标头
	
			var row = "";
			//导出的标题
			var csvTitle = $('#hisStatisticalInfoList').datagrid('getColumnFields');
			//得到title名
			var titleName = [];
			for (i = 0; i < csvTitle.length; i++) {
				var col = $('#hisStatisticalInfoList').datagrid("getColumnOption", csvTitle[i]);
				titleName.push(col.title);
			}
			row = titleName;
			//用换行符追加标签行
			CSV += row + '\r\n';
	
			if (removeLabel) {
				for (var i = 0; i < arrData.rows.length - 1; i++) {
					var rows = "";
					var values = Object.values(arrData.rows[i]);
					for (var j = 0; j < csvTitle.length; j++) {
						rows += values[j] + ",";
					}
					CSV += rows + '\r\n';
				}
	
			} else {
				for (var i = 0; i < arrData.rows.length; i++) {
					var rows = "";
					var values = Object.values(arrData.rows[i]);
					for (var j = 0; j < csvTitle.length; j++)
						rows += values[j] + ",";
					CSV += rows + '\r\n';
				}
			}
	
			if (CSV == '') {
				alert("无数据");
				return;
			}
			var fileName = "";
			fileName += ReportTitle.replace(/ /g, "_");
			var link = document.createElement("a");
			var blob = new Blob([ CSV ], {
				type : 'text/csv'
			});
			link.setAttribute("href", URL.createObjectURL(blob));
			link.style = "visibility:hidden";
			link.download = fileName + ".csv";
			document.body.appendChild(link);
			link.click();
			document.body.removeChild(link);
		}
	
		//导出CSV 获取easyui 表格数据
		function hsiExporterExcel() {
			//获取所有行
			var rowTmp = $('#hisStatisticalInfoList').datagrid('getData');
			if (rowTmp == '')
				return;
			hsiJSONToCSVConvertor(rowTmp, "统计信息数据", true);
		}
	</script>

	<!-- 实现弹窗可移动 -->
	<script type="text/javascript" language="javascript">
		var _move = false; //移动标记
		var _x,
			_y; //鼠标离控件左上角的相对位置
		$(document).ready(function() {
			$("#hsi1").click(function() {
				//alert("click");//点击（松开后触发）
			}).mousedown(function(e) {
				_move = true;
				_x = e.pageX - parseInt($("#hsi1").css("left"));
				_y = e.pageY - parseInt($("#hsi1").css("top"));
			/* $("#div2").fadeTo(20, 0.25); //点击后开始拖动并透明显示 */
			});
			$(document).mousemove(function(e) {
				if (_move) {
					var x = e.pageX - _x; //移动时根据鼠标位置计算控件左上角的绝对位置
					var y = e.pageY - _y;
					$("#hsi1").css({
						top : y,
						left : x
					}); //控件新位置
				}
			}).mouseup(function() {
				_move = false;
			/* $("#div2").fadeTo("fast", 1); //松开鼠标后停止移动并恢复成不透明 */
			});
			//窗口的关闭
			$("#hsiimg").click(function() {
				$("#hsi1").hide();
			});
	
			//鼠标移入移除改变弹窗关闭按钮
			$("#hsichg").on({
				mouseover : function() {
					$(this).attr('src', 'image/close1.png');
				},
				mouseout : function() {
					$(this).attr('src', 'image/close.png');
	
				}
			})
		});
	</script>

	<!-- 页面实现复选框 -->

	<script type="text/javascript">
	
		function hsiShowSelectData() {
			//动态获取风机名称生成下拉列表	
			$.ajax({
				type : "GET",
				url : "getWindInfoController/getWindInfo",
				datatype : 'json',
				success : function(data) {
					for (var i = 0; i < data.length; i++) {
	
						$("#hsifanlist").append("<option value='" + data[i].id + "'>" + data[i].name + "</option>");
					}
				}
			});
		}
	
		function hsiShowTextboxData() {
			//动态获取统计信息测量值	
			$.ajax({
				type : "GET",
				url : "GetOneMinColumnController/getOneDayColumn",
				datatype : 'json',
				success : function(data) {
					for (var i = 0; i < data.length; i++) {
	
						$("#hsilistleft").append("<option value='" + data[i].columnname + "'>" + data[i].columndes + "</option>");
					}
				}
			});
		}
		//获取当前日期的零点
		var st = $("#hsiStartTime").val(new Date(new Date(new Date().toLocaleDateString()).getTime()).format('yyyy-MM-dd hh:mm:ss'));
		//获取当前时间
		var et = $("#hsiEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
		//开始时间框显示默认开始时间
		var stime = st.val();
		//结束时间框显示默认结束时间
		var etime = et.val();
		//鼠标事件（控制复选框下拉列表显隐）
		$('#hsi2').click(function() {
			var stime = $("#hsiStartTime").val(); //开始时间       
			var etime = $("#hsiEndTime").val(); //结束时间
			//获取当前年
			var year = new Date().getFullYear();
			var etimeYear = etime.substring(0, 4);
			if (stime == "") {
				alert("请选择开始时间！！！");
			} else if (etime == "") {
				alert("请选择结束时间！！！");
			} else if (stime > etime) {
				alert("日期输入框中前面的日期不能大于后面的日期，请重新输入！");
			} else if (etimeYear > year) {
				alert("您输入的年份不能超过当前年份！");
			} else {
				if ($("#hsi1").css("display") == "none") {
					$("#hsi1").show(); //显示
				} else {
					$("#hsi1").hide(); //隐藏
				}
			}
	
			$("#hsilistleft option").remove();
			$("#hsilistright option").remove();
			$("#hsilistall option").remove();
			hsiShowSelectData();
			hsiShowTextboxData();
		});
	</script>
	<script type="text/javascript">
		$("#hsifanlist").bind("change", function() {
			$("#hsilistleft option").remove();
			$("#hsilistright option").remove();
			hsiShowTextboxData();
		})
		$(function() {
			//选中左边单个量去右边
			$("#hsiSelectOneToRight").click(function() {
				if (!$("#hsilistleft option").is(":selected")) {
					alert("请选择需要移动的选项");
				} else {
					var fanValue = $("#hsifanlist option:checked").val();
					var fanText = $("#hsifanlist option:checked").text();
					var selectValue = $("#hsilistleft option:selected").val();
					if ($("#hsilistright option[value='" + selectValue + "']").length <= 0) {
						$("#hsilistleft option:selected").each(function() {
							$("#hsilistleft option:selected").appendTo($("#hsilistright"));
							$('#hsilistall').append("<option value='" + fanValue + "-" + $(this).val() + "'>" + fanText + "-" + $(this).text() + "</option>");
						})
					}
				}
			});
	
			//单击全部去右边
			$("#hsiSelectAllToRight").click(function() {
				var fanValue = $("#hsifanlist option:checked").val();
				var fanText = $("#hsifanlist option:checked").text();
				//获取左边值
				var leftList = $("#hsilistleft").find('option');
				for (var i = 0; i < leftList.length; i++) {
					var selectValue = leftList[i].value;
					var selectText = leftList[i].innerText;
					if ($("#hsilistleft option[value='" + selectValue + "']").length >= 0) {
						//将选中风机和右边全部值添加到下边的结果框
						$('#hsilistall').append("<option value='" + fanValue + "-" + selectValue + "'>" + fanText + "-" + selectText + "</option>");
					}
				}
				//左边全部移到右边
				$("#hsilistleft option").appendTo($("#hsilistright"));
			});
	
			//选中单击去左边
			$("#hsiSelectOneToLeft").click(function() {
				if (!$("#hsilistright option").is(":selected")) {
					alert("请选择需要移动的选项")
				} else {
					var fanValue = $("#hsifanlist option:checked").val();
					var fanText = $("#hsifanlist option:checked").text();
					//将右边框选中的值移除，并将结果框中的值清除
					$("#hsilistright option:selected").each(function() {
						$("#hsilistright option[value='" + $(this).val() + "']").appendTo($("#hsilistleft"));
						$("#hsilistall option[value='" + fanValue + "-" + $(this).val() + "']").remove();
					})
				}
			});
	
			//单击全部去左边
			$("#hsiSelectAllToLeft").click(function() {
				$("#hsilistright option").appendTo($("#hsilistleft"));
				$("#hsilistall option").remove();
			});
		});
	
		//点击确认按钮
		function hsiReturnCurrentNode() {
			var stime = $("#hsiStartTime").val(); //开始时间     
			var etime = $("#hsiEndTime").val(); //结束时间
			var fanValue = $("#hsifanlist option:checked").val();
			var listall = $("#hsilistall").find('option');
			if (listall.length == 0) {
				alert("您还没有选择测点！！！");
			} else if (listall.length > 5) {
				alert("选择测点不能超过5个！！！");
			} else {
				//数据加载时显示加载提示框
				$.messager.progress({
					title : '提示',
					msg : '数据请求中，请稍候……',
					text : ''
				});
				var selectText = [];
				var selectValue = [];
				var columnsAll = new Array();
				var cl = {};
				cl["title"] = "时间";
				cl["field"] = "savetime";
				cl["width"] = 60;
				columnsAll.push(cl);
				for (var i = 0; i < listall.length; i++) {
					selectValue.push(listall[i].value);
					selectText.push(listall[i].innerText);
					var col = {}
					col["title"] = selectText[i];
					col["field"] = "cal" + i;
					col["width"] = 60;
					//把这个对象添加到列集合中
					columnsAll.push(col);
				}
				$('#hisStatisticalInfoList').datagrid({
					columns : [ columnsAll ]
				}).datagrid("reload");
				var myChart = echarts.init(document.getElementById('hsimain'));
				$(function() {
					//获取量查询结果
					$.ajax({
						url : "HisStatisticalInfoController/getHisSta",
						type : 'post',
						traditional : true,
						data : {
							"startTime" : stime,
							"endTime" : etime,
							"selectValue" : selectValue,
						}, //向后台传参
						datatype : 'json',
						success : function(result) {
							$("#hisStatisticalInfoList").datagrid('loadData', result);
							var Xtime = []; //横轴
							var yval = [];
							var cal0 = [];
							var cal1 = [];
							var cal2 = [];
							var cal3 = [];
							var cal4 = [];
							for (var i = 0; i < result.length; i++) {
								Xtime.push(result[i].savetime);
								cal0.push(result[i].cal0);
								yval.push(cal0);
								if (selectText.length > 1) {
									cal1.push(result[i].cal1);
									yval.push(cal1);
								}
								if (selectText.length > 2) {
									cal2.push(result[i].cal2);
									yval.push(cal2);
								}
								if (selectText.length > 3) {
									cal3.push(result[i].cal3);
									yval.push(cal3);
								}
								if (selectText.length > 4) {
									cal4.push(result[i].cal4);
									yval.push(cal4);
								}
							}
							var lfStr = (selectText.length * 3) + "%";
							var option = {
								title : {
									text : '统计信息图'
								},
								legend : {
									data : selectText
								},
								xAxis : {
									//type : 'time',
									name : '时间',
									data : Xtime
								},
								tooltip : {
									trigger : 'axis' //坐标轴触发
								},
								grid : {
									left : lfStr,
									right : '3%'
								},
	
	
								yAxis : function() {
									var yAxis = [];
									for (var i = 0; i < selectText.length; i++) {
										var item = {
											position : 'left',
											offset : (40 * i),
											//name : selectText[i], //动态Y轴
											type : 'value'
										};
										yAxis.push(item);
									}
									return yAxis;
								}(),
								series : function() {
									var series = [];
									for (var i = 0; i < selectText.length; i++) {
										var item = {
											data : yval[i], //不同坐标轴值
											symbol : 'none',
											name : selectText[i],
											barMaxWidth : 30,
											yAxisIndex : i, //显示不同的坐标轴
											type : 'line'
										};
										series.push(item);
									}
									return series;
								}()
							};
							// 使用刚指定的配置项和数据显示图表。
							myChart.clear();
							myChart.setOption(option, true);
							//数据加载提示结束
							$.messager.progress('close');
						}
					})
				});
				$("#hsi1").hide(); //隐藏
			}
	
		}
		//点击取消按钮
		function hsiReturnClose() {
			$("#hsi1").hide(); //隐藏
		}
	</script>
</body>
</html>
