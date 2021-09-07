package cn.xjfd.ssm.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.FullMaxPowerData;
import cn.xjfd.ssm.pojo.FullMaxPowerSingleData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.FullMaxPowerDataService;
import cn.xjfd.ssm.util.DataAccuracy;

@Controller
@RequestMapping("FullMaxPowerDataController")
public class FullMaxPowerDataController {

	@Autowired
	FullMaxPowerDataService fullMaxPowerDataService;
	
	@ResponseBody
	@RequestMapping(value = "getFullMaxPowerData" ,method = RequestMethod.POST)
	public FullMaxPowerData getFullMaxPowerData(@RequestParam("startTime") String startTimeStr,@RequestParam("endTime") String endTimeStr) throws ParseException {
		QueryPeriod queryPeriod = new QueryPeriod();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startyear = startTimeStr.substring(0, 4);
		String endyear = endTimeStr.substring(0, 4);
		int startyearint = Integer.parseInt(startyear);
		int endyearint = Integer.parseInt(endyear);
		int yearCount = endyearint - startyearint;
		Date startTime = sdf.parse(startTimeStr);
		Date endTime = sdf.parse(endTimeStr);
		queryPeriod.setStartTime(startTime);
		queryPeriod.setEndTime(endTime);
		if(yearCount == 0) {
			queryPeriod.setYear(startyearint);
			FullMaxPowerData data = fullMaxPowerDataService.getFullMaxPowerData(queryPeriod);
			data.setFullmaxCurp(DataAccuracy.keepThree(data.getFullmaxCurp()));
			data.setFullmaxCurpWind(DataAccuracy.keepThree(data.getFullmaxCurpWind()));
			return data;
		}else if(yearCount == 1){
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setYear(startyearint);
			queryPeriod1.setStartTime(startTime);
			queryPeriod1.setEndTime(endTime);
			FullMaxPowerData data1 = fullMaxPowerDataService.getFullMaxPowerData(queryPeriod1);
			
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setYear(endyearint);
			queryPeriod2.setStartTime(startTime);
			queryPeriod2.setEndTime(endTime);
			FullMaxPowerData data2 = fullMaxPowerDataService.getFullMaxPowerData(queryPeriod2);
			
			double curp1 = data1.getFullmaxCurp();
			double curp2 = data2.getFullmaxCurp();
			
			if(curp2 >= curp1) {
				data2.setFullmaxCurp(DataAccuracy.keepThree(data2.getFullmaxCurp()));
				data2.setFullmaxCurpWind(DataAccuracy.keepThree(data2.getFullmaxCurpWind()));
				return data2;
			}else {
				data1.setFullmaxCurp(DataAccuracy.keepThree(data1.getFullmaxCurp()));
				data1.setFullmaxCurpWind(DataAccuracy.keepThree(data1.getFullmaxCurpWind()));
				return data1;
			}
		}
		return null;
	}
	
	@ResponseBody
	@RequestMapping(value = "getFullMaxPowerSingleData" ,method = RequestMethod.POST)
	public List<FullMaxPowerSingleData> getFullMaxPowerSingleData(@RequestParam("savetime") String savetimeStr) throws ParseException {
		QueryPeriod queryPeriod = new QueryPeriod();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String savetimeYear = savetimeStr.substring(0, 4);

		int savetimeYearint = Integer.parseInt(savetimeYear);
		
		Date savetime = sdf.parse(savetimeStr);
		queryPeriod.setYear(savetimeYearint);
		queryPeriod.setSavetime(savetime);
		List<FullMaxPowerSingleData> datas = fullMaxPowerDataService.getFullMaxPowerSingleData(queryPeriod);
		for (int i = 0; i < datas.size(); i++) {
			datas.get(i).setCurp(DataAccuracy.keepThree(datas.get(i).getCurp()));
			datas.get(i).setWindSpeed(DataAccuracy.keepThree(datas.get(i).getWindSpeed()));
		}
		
		return datas;
		
	}
}
