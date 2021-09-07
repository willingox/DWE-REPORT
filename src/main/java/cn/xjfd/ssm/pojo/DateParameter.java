package cn.xjfd.ssm.pojo;

import java.util.Date;

public class DateParameter {

	private int startYear;
	private int endYear;
	private int yearCount;
	private Date startTime;
	private Date endTime;
	
	
	public DateParameter() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DateParameter(int startYear, int endYear, int yearCount, Date startTime, Date endTime) {
		super();
		this.startYear = startYear;
		this.endYear = endYear;
		this.yearCount = yearCount;
		this.startTime = startTime;
		this.endTime = endTime;
	}
	public int getStartYear() {
		return startYear;
	}
	public void setStartYear(int startYear) {
		this.startYear = startYear;
	}
	public int getEndYear() {
		return endYear;
	}
	public void setEndYear(int endYear) {
		this.endYear = endYear;
	}
	public int getYearCount() {
		return yearCount;
	}
	public void setYearCount(int yearCount) {
		this.yearCount = yearCount;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	
}
