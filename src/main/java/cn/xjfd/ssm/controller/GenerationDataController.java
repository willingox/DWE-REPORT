package cn.xjfd.ssm.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.GenerationPageData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.GenerationDataService;
import cn.xjfd.ssm.util.DataAccuracy;

@RequestMapping("generationDataController")
@Controller
public class GenerationDataController {

	@Autowired
	GenerationDataService generationDataService;
	
	@ResponseBody
	@RequestMapping(value = "getGenerationData" ,method = RequestMethod.POST)
	public List<GenerationPageData> getGenerationData(@RequestParam("startTime") String startTimeStr,@RequestParam("endTime") String endTimeStr, Object request) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		QueryPeriod queryPeriod = new QueryPeriod();
		List<GenerationPageData> generationPageDatas = new ArrayList<GenerationPageData>();
		String startyear = startTimeStr.substring(0, 4);
		String endyear = endTimeStr.substring(0, 4);
		int startyearint = Integer.parseInt(startyear);
		int endyearint = Integer.parseInt(endyear);
		int yearCount = endyearint - startyearint;
		if(yearCount == 0) {
			Date startTime = sdf.parse(startTimeStr);
			Date endTime = sdf.parse(endTimeStr);
			queryPeriod.setYear(startyearint);
			queryPeriod.setStartTime(startTime);
			queryPeriod.setEndTime(endTime);
			generationPageDatas = generationDataService.getGenerationData(queryPeriod);
			for (int i = 0; i < generationPageDatas.size(); i++) {
				generationPageDatas.get(i).setGenwh(DataAccuracy.keepThree(generationPageDatas.get(i).getGenwh()));
				generationPageDatas.get(i).setGenHour(DataAccuracy.keepThree(generationPageDatas.get(i).getGenHour()));
			}
			return generationPageDatas;
		}else if(yearCount == 1) {
			Date startTime = sdf.parse(startTimeStr);
			Date endTimeTemp = sdf.parse(startyear + "-12-31 23:59:59");
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setYear(startyearint);
			queryPeriod1.setStartTime(startTime);
			queryPeriod1.setEndTime(endTimeTemp);
			List<GenerationPageData> Datas1 = generationDataService.getGenerationData(queryPeriod1);
			
			Date startTimeTemp = sdf.parse(endyear + "-01-01 00:00:00");
			Date endTime = sdf.parse(endTimeStr);
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setYear(endyearint);
			queryPeriod2.setStartTime(startTimeTemp);
			queryPeriod2.setEndTime(endTime);
			List<GenerationPageData> Datas2 = generationDataService.getGenerationData(queryPeriod2);
			for (int i = 0; i < Datas2.size(); i++) {
				for (int j = 0; j < Datas1.size(); j++) {
					if(Datas2.get(i).getId() == Datas1.get(j).getId()) {
						double genwh2 = Datas2.get(i).getGenwh();
						double genHour2 = Datas2.get(i).getGenHour();
						double genwh1 = Datas1.get(j).getGenwh();
						double genHour1 = Datas1.get(j).getGenHour();	
						double genwh = genwh2 + genwh1;
						double genHour = genHour2 + genHour1;
						Datas2.get(i).setGenwh(DataAccuracy.keepThree(genwh));
						Datas2.get(i).setGenHour(DataAccuracy.keepThree(genHour));
					}
				}
			}
			return Datas2;
		}
		return generationPageDatas;

	}
}
