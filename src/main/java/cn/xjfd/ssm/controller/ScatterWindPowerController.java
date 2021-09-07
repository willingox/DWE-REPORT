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
import cn.xjfd.ssm.pojo.ScatterWindPowerData;
import cn.xjfd.ssm.pojo.WindSpeedData;
import cn.xjfd.ssm.service.ScatterWindPowerService;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("ScatterWindPowerController")
public class ScatterWindPowerController {

	@Autowired
	ScatterWindPowerService scatterWindPowerService;
	
	@ResponseBody
	@RequestMapping(value = "getScatterWindPower", method = RequestMethod.POST)
	public List<ScatterWindPowerData> getScatterWindPower(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("gid") String gid) throws ParseException{
		List<ScatterWindPowerData> scatterWindPowerDatas = new ArrayList<ScatterWindPowerData>();
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		int parseGid = Integer.parseInt(gid);
		
		if(dateParameter.getYearCount() == 0) {
			QueryPeriod queryPeriod = new QueryPeriod();
			queryPeriod.setStartTime(dateParameter.getStartTime());
			queryPeriod.setEndTime(dateParameter.getEndTime());
			queryPeriod.setYear(dateParameter.getStartYear());
			queryPeriod.setGid(parseGid);
			scatterWindPowerDatas = scatterWindPowerService.getScatterWindPower(queryPeriod);
			return scatterWindPowerDatas;
		}else if(dateParameter.getYearCount() == 1) {
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setStartTime(dateParameter.getStartTime());
			queryPeriod1.setEndTime(dateParameter.getEndTime());
			queryPeriod1.setYear(dateParameter.getStartYear());
			queryPeriod1.setGid(parseGid);
			
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setStartTime(dateParameter.getStartTime());
			queryPeriod2.setEndTime(dateParameter.getEndTime());
			queryPeriod2.setYear(dateParameter.getEndYear());
			queryPeriod2.setGid(parseGid);

			List<ScatterWindPowerData> data1 = scatterWindPowerService.getScatterWindPower(queryPeriod1);
			List<ScatterWindPowerData> data2 = scatterWindPowerService.getScatterWindPower(queryPeriod2);
			data2.addAll(data1);
		
			return data2;
		}
		
		return scatterWindPowerDatas;
	}
}
