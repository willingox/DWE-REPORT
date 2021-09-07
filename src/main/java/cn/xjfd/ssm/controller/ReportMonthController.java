package cn.xjfd.ssm.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.DateParameter;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportDayData;
import cn.xjfd.ssm.pojo.ReportMonthData;
import cn.xjfd.ssm.service.ReportMonthService;
import cn.xjfd.ssm.util.DateFormatting;
import cn.xjfd.ssm.util.GetSpecifiedDayBefore;

@Controller
@RequestMapping("ReportMonthController")
public class ReportMonthController {

	@Autowired
	ReportMonthService reportMonthService;
	
	@ResponseBody
	@RequestMapping(value = "getReportMonth", method = RequestMethod.POST)
	public List<ReportMonthData> getReportMonth(@RequestParam("startTime") String startTimeStr) throws ParseException{
			
			List<ReportMonthData> reportMonthData = new ArrayList<ReportMonthData>();
			DateParameter dateParameter = DateFormatting.monDateFormatting(startTimeStr);
			
			QueryPeriod queryPeriod = new QueryPeriod();
//			queryPeriod.setStartTime(dateParameter.getStartTime());
			queryPeriod.setStartTimeStr(startTimeStr);
			queryPeriod.setYear(dateParameter.getStartYear());
			reportMonthData = reportMonthService.getReportMonth(queryPeriod);
				
			
	
			return reportMonthData;
		}
}
