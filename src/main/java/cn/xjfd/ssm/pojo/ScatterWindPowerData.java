package cn.xjfd.ssm.pojo;

public class ScatterWindPowerData {

	private int gid;
	private String name;
	private double wind;
	private double power;
	
	
	public ScatterWindPowerData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ScatterWindPowerData(int gid, String name, double wind, double power) {
		super();
		this.gid = gid;
		this.name = name;
		this.wind = wind;
		this.power = power;
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
	public double getWind() {
		return wind;
	}
	public void setWind(double wind) {
		this.wind = wind;
	}
	public double getPower() {
		return power;
	}
	public void setPower(double power) {
		this.power = power;
	}
	
	
}
