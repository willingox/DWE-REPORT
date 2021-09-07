package cn.xjfd.ssm.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import cn.xjfd.ssm.pojo.DateParameter;

public class DateFormatting {

	public static DateParameter dateFormatting(String startTimeStr, String endTimeStr) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startyearStr = startTimeStr.substring(0, 4);
		String endyearStr = endTimeStr.substring(0, 4);
		int startyear = Integer.parseInt(startyearStr);
		int endyear = Integer.parseInt(endyearStr);
		int yearCount = endyear - startyear;
		Date startTime = sdf.parse(startTimeStr);
		Date endTime = sdf.parse(endTimeStr);
		DateParameter datePara = new DateParameter();
		datePara.setStartYear(startyear);
		datePara.setEndYear(endyear);
		datePara.setStartTime(startTime);
		datePara.setEndTime(endTime);
		datePara.setYearCount(yearCount);
		return datePara;
	}
	
	public static DateParameter dateFormatting(String startTimeStr) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String startyearStr = startTimeStr.substring(0, 4);
		int startyear = Integer.parseInt(startyearStr);
		Date startTime = sdf.parse(startTimeStr);
		DateParameter datePara = new DateParameter();
		datePara.setStartYear(startyear);
		datePara.setStartTime(startTime);
		return datePara;
	}
	
	public static DateParameter monDateFormatting(String startTimeStr) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		String startyearStr = startTimeStr.substring(0, 4);
		int startyear = Integer.parseInt(startyearStr);
		Date startTime = sdf.parse(startTimeStr);
		DateParameter datePara = new DateParameter();
		datePara.setStartYear(startyear);
		datePara.setStartTime(startTime);
		return datePara;
	}
	
//	public static DateParameter yearDateFormatting(String startTimeStr) throws ParseException {
////		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
//		String startyearStr = startTimeStr.substring(0, 4);
//		int startyear = Integer.parseInt(startyearStr);
//		Date startTime = sdf.parse(startTimeStr);
//		DateParameter datePara = new DateParameter();
//		datePara.setStartYear(startyear);
//		datePara.setStartTime(startTime);
//		return datePara;
//	}
}
