package cn.xjfd.ssm.pojo;

public class ReportData {

	public String name;
	public int id;
	public String maxWindSpeed;
	public String avgWindSpeed;
	public String minWindSpeed;
	public String maxCurp;
	public String minCurp;
	public String avgCurp;
	public String genwh;
	public String failDowntime;
	
	
	public ReportData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReportData(String name, int id, String maxWindSpeed, String avgWindSpeed, String minWindSpeed,
			String maxCurp, String minCurp, String avgCurp, String genwh, String failDowntime) {
		super();
		this.name = name;
		this.id = id;
		this.maxWindSpeed = maxWindSpeed;
		this.avgWindSpeed = avgWindSpeed;
		this.minWindSpeed = minWindSpeed;
		this.maxCurp = maxCurp;
		this.minCurp = minCurp;
		this.avgCurp = avgCurp;
		this.genwh = genwh;
		this.failDowntime = failDowntime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMaxWindSpeed() {
		return maxWindSpeed;
	}
	public void setMaxWindSpeed(String maxWindSpeed) {
		this.maxWindSpeed = maxWindSpeed;
	}
	public String getAvgWindSpeed() {
		return avgWindSpeed;
	}
	public void setAvgWindSpeed(String avgWindSpeed) {
		this.avgWindSpeed = avgWindSpeed;
	}
	public String getMinWindSpeed() {
		return minWindSpeed;
	}
	public void setMinWindSpeed(String minWindSpeed) {
		this.minWindSpeed = minWindSpeed;
	}
	public String getMaxCurp() {
		return maxCurp;
	}
	public void setMaxCurp(String maxCurp) {
		this.maxCurp = maxCurp;
	}
	public String getMinCurp() {
		return minCurp;
	}
	public void setMinCurp(String minCurp) {
		this.minCurp = minCurp;
	}
	public String getAvgCurp() {
		return avgCurp;
	}
	public void setAvgCurp(String avgCurp) {
		this.avgCurp = avgCurp;
	}
	public String getGenwh() {
		return genwh;
	}
	public void setGenwh(String genwh) {
		this.genwh = genwh;
	}
	public String getFailDowntime() {
		return failDowntime;
	}
	public void setFailDowntime(String failDowntime) {
		this.failDowntime = failDowntime;
	}
	
	
}
