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
import cn.xjfd.ssm.pojo.OperatRecordData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.OperatRecordService;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("OperatRecordController")
public class OperatRecordController {

	@Autowired
	OperatRecordService operatRecordService;
	
	@ResponseBody
	@RequestMapping(value = "getOperatRecord", method = RequestMethod.POST)
	public List<OperatRecordData> getOperatRecord(@RequestParam("startTime") String startTimeStr, @RequestParam("endTime") String endTimeStr, @RequestParam("ids") int[] ids) throws ParseException{
		List<OperatRecordData> operatRecordDatas = new ArrayList<OperatRecordData>();
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		
		if(dateParameter.getYearCount() == 0) {
			QueryPeriod queryPeriod = new QueryPeriod();
			queryPeriod.setStartTime(dateParameter.getStartTime());
			queryPeriod.setEndTime(dateParameter.getEndTime());
			queryPeriod.setYear(dateParameter.getStartYear());
			queryPeriod.setIds(ids);

			operatRecordDatas = operatRecordService.getOperatRecord(queryPeriod);
			return operatRecordDatas;
		}else if(dateParameter.getYearCount() == 1) {
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setStartTime(dateParameter.getStartTime());
			queryPeriod1.setEndTime(dateParameter.getEndTime());
			queryPeriod1.setYear(dateParameter.getStartYear());
			queryPeriod1.setIds(ids);
			
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setStartTime(dateParameter.getStartTime());
			queryPeriod2.setEndTime(dateParameter.getEndTime());
			queryPeriod2.setYear(dateParameter.getEndYear());
			queryPeriod2.setIds(ids);
			
			List<OperatRecordData> data1 = operatRecordService.getOperatRecord(queryPeriod1);
			List<OperatRecordData> data2 = operatRecordService.getOperatRecord(queryPeriod2);
			data1.addAll(data2);
			
			return data1;
		}
		return operatRecordDatas;
	}
}
