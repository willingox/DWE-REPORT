<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">

<title>设备故障查询</title>
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
	<div class="easyui-panel" title="Nested Panel"
		data-options="width:'100%',minHeight:820,noheader:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div
				style="float:left;width:20px;height:100%;display:flex;align-items:center;cursor:pointer;">
				<div
					style="position: fixed;z-index:999;display:flex;align-items:center;">
					<div id="rycs1"
						style="overflow:auto;width:210px;height:800px;float:left;display:none;background-color:#ffffff;cursor:pointer;">
						<div style="padding-top:15px; padding-left:20px; float:left"
							align="center" onclick='show("rycsWindName","rycswindimgs")'>
							<img style="width:13px;height:13px" id="rycswindimgs"
								src="image/on.png">
						</div>
						<div>
							<ul style="list-style-type: none;">
								<li><input type="checkbox"
									style="width:13px;cursor:pointer;" value="选择风机" />选择风机(全选/全不选)
									<ul style="list-style-type: none;" id="rycsWindName">
									</ul></li>
							</ul>
						</div>
					</div>
					<div id="rycs2"
						style="width:18px;height:65px;text-align:center;background-color:#ffffff">
						<img style="width:18px;height:65px;" src="image/gg.png">
					</div>
				</div>
			</div>
			<div data-options="region:'center'"
				style="padding-left:20px;padding-top:5px;">
				<div style="width: 100%; height: 30px;">
					开始时间&nbsp;<input type="text" id="rycsStartTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;&nbsp;
					结束时间&nbsp;<input type="text" id="rycsEndTime" class="Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowWeek:true,isShowClear:true,readOnly:true,firstDayOfWeek:1,maxDate:'2022-12-28'})"
						data-options="required:true,editable:false"
						style="width: 160px; height: 22px;">&nbsp;&nbsp;
					<button id="rycs4" type="button" class="easyui-linkbutton"
						iconCls="icon-zoom-in">选择指标</button>
					&nbsp;&nbsp;
					<button id="csv" type="button" onclick="rycsExporterExcel()"
						class="easyui-linkbutton" iconCls="icon-save">导出CSV</button>
				</div>
				<!-- 选择指标弹出框 -->
				<div id="rycs3"
					style="position: absolute;left: 400px;top: 50px;display:none;z-index: 9999;">
					<div id="title"
						style="width: 500px;height: 19px;background: #5B8BD9;border-top-left-radius: 10px;border-top-right-radius: 10px;">
						<div id="rycsimg"
							style="float: right;width: 39px;height: 19px;text-align: center;cursor:pointer;">
							<img id="rycschg" src="image/close.png"
								style="width: 30px;height: 19px;text-align: center;">
						</div>
					</div>
					<div
						style="width: 500px;">	
						<div style="overflow:auto;padding-left:120px;height: 470px;background-color: #ecf3fa;">
							<ul style="list-style-type: none;">
								<li><input type="checkbox"
									style="width:13px;cursor:pointer;" value="选择测点" />选择测点(全选/全不选)
									<ul style="list-style-type: none;" id="rycsName">
									</ul></li>
							</ul>
						</div>
						<div style="width: 500px;height: 50px;text-align: center;padding-top:15px;border-bottom-left-radius: 10px;border-bottom-right-radius: 10px;background-color: #ecf3fa;">
							<button id="ok" type="button"
								onclick="javascript:rycsReturnCurrentNode()"
								class="easyui-linkbutton" iconCls="icon-ok">确&nbsp;&nbsp;定</button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button id="cancel" type="button"
								onclick="javascript:rycsReturnClose()"
								class="easyui-linkbutton" iconCls="icon-cancel">取&nbsp;&nbsp;消</button>
						</div>
					</div>
				</div>
				
				<div id="stalistDiv" style="width: 100%">
					<table class="easyui-datagrid" id="rycsStatisticalInfoList"
						style="width: auto" title="遥测统计信息列表"
						data-options="singleSelect:false,fitColumns:true,striped:true,method:'get'">
						<thead>
							<tr>
								<th data-options="field:'savetime',width:60">时间</th>
								<th data-options="field:'name',width:60">名称</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function rycsJSONToCSVConvertor(JSONData, ReportTitle, removeLabel) {
			//如果JSONData不是对象，那么JSON。parse将解析对象中的JSON字符串
			var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData)
				: JSONData;
			var CSV = '';
			//在第一行或第一行设置报表标题
			CSV += ReportTitle + '\r\n\n';
	
			//此条件将生成标签/标头
			var row = "";
			//导出的标题
			var csvTitle = $('#rycsStatisticalInfoList').datagrid('getColumnFields');
			//得到title名
			var titleName = [];
			for (i = 0; i < csvTitle.length; i++) {
				var col = $('#rycsStatisticalInfoList').datagrid("getColumnOption", csvTitle[i]);
				titleName.push(col.title); //把TITLEPUSH到数组里去
			}
			row = titleName;
			//用换行符追加标签行
			CSV += row + '\r\n';
	
			if (removeLabel) {
				for (var i = 0; i < arrData.rows.length - 1; i++) {
					var rows = "";
					//var names=Object.keys(arrData.rows[i]);
					//alert(names);
					var values = Object.values(arrData.rows[i]);
					//alert(values);
					for (var j = 0; j < csvTitle.length; j++) {
						rows += values[j] + ",";
					//alert(arrData.rows[i][curnames]);
					}
					CSV += rows + '\r\n';
				}
	
			} else {
				for (var i = 0; i < arrData.rows.length; i++) {
					var rows = "";
					var values = Object.values(arrData.rows[i]);
					//alert(values);
					for (var j = 0; j < csvTitle.length; j++)
						rows += values[j] + ",";
					//alert(rows);
					CSV += rows + '\r\n';
				}
			}
	
			if (CSV == '') {
				alert("无数据");
				return;
			}
			var fileName = "";
			//           var fileName = getNowFormatDate();
			fileName += ReportTitle.replace(/ /g, "_");
			var link = document.createElement("a");
			//           var debug = {hello: CSV};
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
		function rycsExporterExcel() {
			//获取所有行
			var rowTmp = $('#rycsStatisticalInfoList').datagrid('getData');
			if (rowTmp == '')
				return;
			rycsJSONToCSVConvertor(rowTmp, "遥测统计信息数据", true);
		}
	</script>
	
	<!-- 实现弹窗可移动 -->
	<script type="text/javascript" language="javascript">
		var _move = false; //移动标记
		var _x,
			_y; //鼠标离控件左上角的相对位置
		$(document).ready(function() {
			$("#rycs3").click(function() {
				//alert("click");//点击（松开后触发）
			}).mousedown(function(e) {
				_move = true;
				_x = e.pageX - parseInt($("#rycs3").css("left"));
				_y = e.pageY - parseInt($("#rycs3").css("top"));
			/* $("#div2").fadeTo(20, 0.25); //点击后开始拖动并透明显示 */
			});
			$(document).mousemove(function(e) {
				if (_move) {
					var x = e.pageX - _x; //移动时根据鼠标位置计算控件左上角的绝对位置
					var y = e.pageY - _y;
					$("#rycs3").css({
						top : y,
						left : x
					}); //控件新位置
				}
			}).mouseup(function() {
				_move = false;
			/* $("#div2").fadeTo("fast", 1); //松开鼠标后停止移动并恢复成不透明 */
			});
			//窗口的关闭
			$("#rycsimg").click(function() {
				$("#rycs3").hide();
			});
	
			//鼠标移入移除改变弹窗关闭按钮
			$("#rycschg").on({
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
		//点击展开/关闭按钮出现风机复选框
		$(document).ready(function() {
			$("input:checkbox").click(function() {
				var objP = $(this).parent().parent();
				var objC = $(this).next();
				var len = $(objP).find("input:checkbox").length;
				//判断父级是否被选中
				if ($(objC).is("ul") && $(this).is("input:checkbox:checked")) {
					$(objC).find("input:checkbox").prop("checked", true);
				} else {
					$(objC).find("input:checkbox").prop("checked", false);
				}
				//判断子级是否全部被选中
				if ($(objP).find("input:checkbox:checked").length == len) {
					$(objP).prev("input:checkbox").prop("checked", true);
				} else {
					$(objP).prev("input:checkbox").prop("checked", false);
				}
	
	
			});
		});
	
		//选中风机复选框函数
		function rycsCheckbox(ids) {
			obj = document.getElementsByName("rycsMycheck");
			for (k in obj) {
				if (obj[k].checked) {
					ids.push(obj[k].value);
				}
			}
		}
		//鼠标事件（控制复选框下拉列表显隐）
		$('#rycs2').mouseover(function() {
			if ($("#rycs1").css("display") == "none") {
				$("#rycs1").show(); //显示
				$("#rycs2").hide();
			} else {
				$("#rycs1").hide(); //隐藏
				$("#rycs2").show();
			}
		});
	
		//鼠标离开下拉框区域隐藏下拉框，显示按钮
		$('#rycs1').mouseleave(function() {
			$("#rycs1").hide(); //隐藏
			$("#rycs2").show();
		});
	
		//获取当前日期的零点
		var st = $("#rycsStartTime").val(new Date(new Date().getTime()-24*60*60*1000).format('yyyy-MM-dd hh:mm:ss'));
		//获取当前时间
		var et = $("#rycsEndTime").val(new Date().format('yyyy-MM-dd hh:mm:ss'));
		//开始时间框显示默认开始时间
		var stime = st.val();
		//结束时间框显示默认结束时间
		var etime = et.val();
		//鼠标事件（控制复选框下拉列表显隐）
		$('#rycs4').click(function() {
			var stime = $("#rycsStartTime").val(); //开始时间       
			var etime = $("#rycsEndTime").val(); //结束时间
			//获取当前年
			var year = new Date().getFullYear();
			var etimeYear = etime.substring(0, 4);
			var ids = [];
			rycsCheckbox(ids);
			if (stime == "") {
				alert("请选择开始时间！！！");
			} else if (etime == "") {
				alert("请选择结束时间！！！");
			} else if (stime > etime) {
				alert("日期输入框中前面的日期不能大于后面的日期，请重新输入！");
			} else if (etimeYear > year) {
				alert("您输入的年份不能超过当前年份！");
			} else if (ids.length == 0) {
				alert("您还没有选择风机！");
			} else {
				if ($("#rycs3").css("display") == "none") {
					$("#rycs3").show(); //显示
				} else {
					$("#rycs3").hide(); //隐藏
	
				}
	
			}
	
		});
	</script>
	<script type="text/javascript">
		$(function() {
			//动态获取风机名称生成下拉列表	(动态获取的风机名)
			$.ajax({
				type : "GET",
				url : "getWindInfoController/getWindInfo",
				datatype : 'json',
				success : function(result) {
					//循环遍历出每一个风机名称
					for (var i = 0; i < result.length; i++) {
						//将获取的风机名称逐个填充到下拉列表中
						$("#rycsWindName").append("<li>" + "<input type='checkbox' name='rycsMycheck' style='width:13px;cursor:pointer;'  value='" + result[i].id + "'>" + result[i].name + "</li>");
	
					}
					//默认选中第一个复选框
					//$("input[name='rycsMycheck']")[0].checked = true;
					//默认选中所有复选框
					$("input[name='rycsMycheck']").prop("checked", true);
				}
			});
	
			//动态获取重要量测测量值
			$.ajax({
				type : "GET",
				url : "GetOneMinColumnController/getOneDayColumn",
				datatype : 'json',
				success : function(result) {
					//循环遍历测点
					for (var i = 0; i < result.length; i++) {
						//将获取的风机测量点逐个填充到下拉列表中
						$("#rycsName").append("<li>" + "<input type='checkbox' name='rycsCheck' style='width:13px;cursor:pointer;'  value='" + result[i].columnname + "'>" + result[i].columndes + "</li>");
					}
				}
			});
		});
	
		//点击确认按钮
		function rycsReturnCurrentNode() {
			var stime = $("#rycsStartTime").val(); //开始时间     
			var etime = $("#rycsEndTime").val(); //结束时间	
			//获取复选框风机value
			var ids = [];
			rycsCheckbox(ids);
			var ycids = []; //定义测点复选框value
			var ycvalue = []; //定义测点复选框文本值
			objs = document.getElementsByName("rycsCheck");
			for (m in objs) {
				if (objs[m].checked) {
					ycids.push(objs[m].value);
					ycvalue.push(objs[m].nextSibling.nodeValue);
				}
			}
			if (ycids.length == 0) {
				alert("您还没有选择测点！");
			} else {
				//数据加载时显示加载提示框
				$.messager.progress({
					title : '提示',
					msg : '数据请求中，请稍候……',
					text : ''
				});
				document.getElementById('stalistDiv').style.width = (ycids.length * 150) + 'px';
				var columnsAll = new Array();
				var cl = {};
				cl["title"] = "时间";
				cl["field"] = "savetime";
				cl["width"] = 60;
				columnsAll.push(cl);
				var cln = {};
				cln["title"] = "名称";
				cln["field"] = "name";
				cln["width"] = 60;
				columnsAll.push(cln);
				for (var i = 0; i < ycvalue.length; i++) {
					var col = {}
					col["title"] = ycvalue[i];
					col["field"] = "cal" + i;
					col["width"] = 60;
					//把这个对象添加到列集合中
					columnsAll.push(col);
				}
				$('#rycsStatisticalInfoList').datagrid({
					columns : [ columnsAll ]
				}).datagrid("reload");
				$(function() {
					//获取量查询结果
					$.ajax({
						url : "ReportYCStatisticalInfoController/getYCSta",
						type : 'post',
						traditional : true,
						data : {
							"startTime" : stime,
							"endTime" : etime,
							"selectValue" : ycids,
							"ids" : ids, //此处为弹出框里的选择的测点参数值
						}, //向后台传参
						datatype : 'json',
						success : function(result) {
							$("#rycsStatisticalInfoList").datagrid('loadData', result);
							//数据加载提示结束
							$.messager.progress('close');
						}
					});
				});
				$("#rycs3").hide(); //隐藏
			}
		}
		//点击取消按钮
		function rycsReturnClose() {
			$("#rycs3").hide(); //隐藏
		}
	</script>
</body>
</html>
