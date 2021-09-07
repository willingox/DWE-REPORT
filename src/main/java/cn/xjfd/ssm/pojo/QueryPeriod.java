package cn.xjfd.ssm.pojo;

import java.util.Date;

public class QueryPeriod {

	private int year;
	private Date startTime;
	private Date endTime;
	private int id;
	private int[] ids;
	private Date savetime;
	private int gid;
	private int[] gids;
	private int[] queryType;
	private String keywords;
	private String startTimeStr;
	private String columnname;
	private String sql;
	
	
	
	
	public QueryPeriod() {
		super();
		// TODO Auto-generated constructor stub
	}



	public QueryPeriod(Date startTime, Date endTime) {
		super();
		this.startTime = startTime;
		this.endTime = endTime;
	}

	
	
	
	
	public String getSql() {
		return sql;
	}



	public void setSql(String sql) {
		this.sql = sql;
	}



	public String getColumnname() {
		return columnname;
	}



	public void setColumnname(String columnname) {
		this.columnname = columnname;
	}



	public String getStartTimeStr() {
		return startTimeStr;
	}



	public void setStartTimeStr(String startTimeStr) {
		this.startTimeStr = startTimeStr;
	}



	public int[] getIds() {
		return ids;
	}



	public void setIds(int[] ids) {
		this.ids = ids;
	}



	public int[] getGids() {
		return gids;
	}



	public void setGids(int[] gids) {
		this.gids = gids;
	}



	public int[] getQueryType() {
		return queryType;
	}



	public void setQueryType(int[] queryType) {
		this.queryType = queryType;
	}



	public String getKeywords() {
		return keywords;
	}



	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}



	public Date getSavetime() {
		return savetime;
	}



	public void setSavetime(Date savetime) {
		this.savetime = savetime;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public int getYear() {
		return year;
	}



	public void setYear(int year) {
		this.year = year;
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



	public int getGid() {
		return gid;
	}



	public void setGid(int gid) {
		this.gid = gid;
	}
	
	



	
	
	
	
}
