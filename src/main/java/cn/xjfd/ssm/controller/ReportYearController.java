package cn.xjfd.ssm.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

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
import cn.xjfd.ssm.pojo.ReportYearData;
import cn.xjfd.ssm.service.ReportYearService;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("ReportYearController")
public class ReportYearController {

	@Autowired
	ReportYearService reportYearService;
	
	@ResponseBody
	@RequestMapping(value = "getReportYear", method = RequestMethod.POST)
	public List<ReportYearData> getReportYear(@RequestParam("startTime") String startTimeStr){
		
		List<ReportYearData> reportYearData = new ArrayList<ReportYearData>();
		
		QueryPeriod queryPeriod = new QueryPeriod();

		queryPeriod.setStartTimeStr(startTimeStr);
		
		queryPeriod.setYear(Integer.parseInt(startTimeStr));
		
		reportYearData = reportYearService.getReportYear(queryPeriod);
		
		return reportYearData;
	}
}
