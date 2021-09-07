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
import cn.xjfd.ssm.pojo.EffectiveHoursData;
import cn.xjfd.ssm.pojo.FailureNumberData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.FailureNumberService;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("FailureNumberController")
public class FailureNumberController {

	@Autowired
	FailureNumberService failureNumberService;
	
	@ResponseBody
	@RequestMapping(value = "getFailureNumber", method = RequestMethod.POST)
	public List<FailureNumberData> getFailureNumber(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("ids") String[] ids) throws ParseException{
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		
		List<FailureNumberData> FailureNumberDatas = new ArrayList<FailureNumberData>();
		
		if(dateParameter.getYearCount() == 0) {
			QueryPeriod queryPeriod = new QueryPeriod();
			queryPeriod.setStartTime(dateParameter.getStartTime());
			queryPeriod.setEndTime(dateParameter.getEndTime());
			queryPeriod.setYear(dateParameter.getStartYear());

			for (String id : ids) {
				int parseId = Integer.parseInt(id);
				queryPeriod.setId(parseId);
				FailureNumberData data = failureNumberService.getFailureNumber(queryPeriod);
				FailureNumberDatas.add(data);
			}
			return FailureNumberDatas;
		}else if(dateParameter.getYearCount() == 1) {
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setStartTime(dateParameter.getStartTime());
			queryPeriod1.setEndTime(dateParameter.getEndTime());
			queryPeriod1.setYear(dateParameter.getStartYear());
			
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setStartTime(dateParameter.getStartTime());
			queryPeriod2.setEndTime(dateParameter.getEndTime());
			queryPeriod2.setYear(dateParameter.getEndYear());
			
			for (String id : ids) {
				int parseId = Integer.parseInt(id);
				queryPeriod1.setId(parseId);
				FailureNumberData data1 = failureNumberService.getFailureNumber(queryPeriod1);
				
				queryPeriod2.setId(parseId);
				FailureNumberData data2 = failureNumberService.getFailureNumber(queryPeriod2);
				data2.setFailureNumber(data2.getFailureNumber() + data1.getFailureNumber());
				FailureNumberDatas.add(data2);
			}
			return FailureNumberDatas;
		}
		return FailureNumberDatas;
		
		
	}
}
