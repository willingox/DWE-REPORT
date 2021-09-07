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
import cn.xjfd.ssm.pojo.EquipmentFailureData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.WindSpeedData;
import cn.xjfd.ssm.service.EquipmentFailureService;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("EquipmentFailureController")
public class EquipmentFailureController {

	@Autowired
	EquipmentFailureService equipmentFailureService;
	
	@ResponseBody
	@RequestMapping(value = "getEquipmentFailure", method = RequestMethod.POST)
	public List<EquipmentFailureData> getEquipmentFailure(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("gids") int[] gids, @RequestParam("queryType") int[] queryType, @RequestParam("keywords") String keywords) throws ParseException{
		List<EquipmentFailureData> EquipmentFailureDatas = new ArrayList<EquipmentFailureData>();
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		
		if(dateParameter.getYearCount() == 0) {
			QueryPeriod queryPeriod = new QueryPeriod();
			queryPeriod.setStartTime(dateParameter.getStartTime());
			queryPeriod.setEndTime(dateParameter.getEndTime());
			queryPeriod.setYear(dateParameter.getStartYear());
			queryPeriod.setGids(gids);
			queryPeriod.setQueryType(queryType);
			queryPeriod.setKeywords(keywords);

			EquipmentFailureDatas = equipmentFailureService.getEquipmentFailure(queryPeriod);
			return EquipmentFailureDatas;
		}else if(dateParameter.getYearCount() == 1) {
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setStartTime(dateParameter.getStartTime());
			queryPeriod1.setEndTime(dateParameter.getEndTime());
			queryPeriod1.setYear(dateParameter.getStartYear());
			queryPeriod1.setGids(gids);
			queryPeriod1.setQueryType(queryType);
			queryPeriod1.setKeywords(keywords);
			
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setStartTime(dateParameter.getStartTime());
			queryPeriod2.setEndTime(dateParameter.getEndTime());
			queryPeriod2.setYear(dateParameter.getEndYear());
			queryPeriod2.setGids(gids);
			queryPeriod2.setQueryType(queryType);
			queryPeriod2.setKeywords(keywords);
			
			List<EquipmentFailureData> data1 = equipmentFailureService.getEquipmentFailure(queryPeriod1);
			List<EquipmentFailureData> data2 = equipmentFailureService.getEquipmentFailure(queryPeriod2);
			data1.addAll(data2);
			
			return data1;
		}
		return EquipmentFailureDatas;
	}
}
