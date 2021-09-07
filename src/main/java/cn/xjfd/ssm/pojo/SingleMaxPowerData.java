package cn.xjfd.ssm.pojo;

public class SingleMaxPowerData {

	private int id;
	private String name;
	private double maxCurp;
	
	private String maxTime;
	private double maxWind;
	
	
	public SingleMaxPowerData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SingleMaxPowerData(double maxCurp, String name, String maxTime, double maxWind) {
		super();
		this.maxCurp = maxCurp;
		this.name = name;
		this.maxTime = maxTime;
		this.maxWind = maxWind;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getMaxCurp() {
		return maxCurp;
	}
	public void setMaxCurp(double maxCurp) {
		this.maxCurp = maxCurp;
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
	
	
}
