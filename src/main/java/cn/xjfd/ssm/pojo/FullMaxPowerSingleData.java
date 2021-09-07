package cn.xjfd.ssm.pojo;

public class FullMaxPowerSingleData {

	private String name;
	private double curp;
	private String savetime;
	private double windSpeed;
	
	
	
	public FullMaxPowerSingleData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public FullMaxPowerSingleData(String name, double curp, String savetime, double windSpeed) {
		super();
		this.name = name;
		this.curp = curp;
		this.savetime = savetime;
		this.windSpeed = windSpeed;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getCurp() {
		return curp;
	}
	public void setCurp(double curp) {
		this.curp = curp;
	}
	public String getSavetime() {
		return savetime;
	}
	public void setSavetime(String savetime) {
		this.savetime = savetime;
	}
	public double getWindSpeed() {
		return windSpeed;
	}
	public void setWindSpeed(double windSpeed) {
		this.windSpeed = windSpeed;
	}
	
	
}
