package cn.xjfd.ssm.pojo;

public class WindSpeedData {

	private int gid;
	private String name;
	private double avgWind;
	private String maxTime;
	private double maxWind;
	private String minTime;
	private double minWind;

	
	
	public WindSpeedData(int gid, String name, String maxTime, double maxWind, String minTime, double minWind,
			double avgWind) {
		super();
		this.gid = gid;
		this.name = name;
		this.maxTime = maxTime;
		this.maxWind = maxWind;
		this.minTime = minTime;
		this.minWind = minWind;
		this.avgWind = avgWind;
	}
	public WindSpeedData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getGid() {
		return gid;
	}
	public void setGid(int gid) {
		this.gid = gid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMaxTime() {
		return maxTime;
	}
	public void setMaxTime(String maxTime) {
		this.maxTime = maxTime;
	}
	public double getMaxWind() {
		return maxWind;
	}
	public void setMaxWind(double maxWind) {
		this.maxWind = maxWind;
	}
	public String getMinTime() {
		return minTime;
	}
	public void setMinTime(String minTime) {
		this.minTime = minTime;
	}
	public double getMinWind() {
		return minWind;
	}
	public void setMinWind(double minWind) {
		this.minWind = minWind;
	}
	public double getAvgWind() {
		return avgWind;
	}
	public void setAvgWind(double avgWind) {
		this.avgWind = avgWind;
	}
	
	
}
