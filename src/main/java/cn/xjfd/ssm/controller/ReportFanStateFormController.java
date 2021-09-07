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
import cn.xjfd.ssm.pojo.FanStateData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.ReportFanStateFormService;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("ReportFanStateFormController")
public class ReportFanStateFormController {

	@Autowired
	ReportFanStateFormService reportFanStateFormService;
	
	@ResponseBody
	@RequestMapping(value = "getFanSta", method = RequestMethod.POST)
	public List<FanStateData> getFanSta(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("gids") int[] gids) throws ParseException{
		
		List<FanStateData> fanStateData = new ArrayList<FanStateData>();
		DateParameter date = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		QueryPeriod queryPeriod = new QueryPeriod();
		queryPeriod.setEndTime(date.getEndTime());
		queryPeriod.setYear(date.getStartYear());
		queryPeriod.setStartTime(date.getStartTime());
		queryPeriod.setGids(gids);
		
		fanStateData = reportFanStateFormService.getFanSta(queryPeriod);
		return fanStateData;
		
	}
}
