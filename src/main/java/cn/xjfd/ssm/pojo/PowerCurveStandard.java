package cn.xjfd.ssm.pojo;

public class PowerCurveStandard {

	private String windvelval;
	private String configure;
	private double genpwd;
	private String weight;
	
	
	
	public PowerCurveStandard() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PowerCurveStandard(String windvelval, String configure, double genpwd, String weight) {
		super();
		this.windvelval = windvelval;
		this.configure = configure;
		this.genpwd = genpwd;
		this.weight = weight;
	}
	public String getWindvelval() {
		return windvelval;
	}
	public void setWindvelval(String windvelval) {
		this.windvelval = windvelval;
	}
	public String getConfigure() {
		return configure;
	}
	public void setConfigure(String configure) {
		this.configure = configure;
	}
	public double getGenpwd() {
		return genpwd;
	}
	public void setGenpwd(double genpwd) {
		this.genpwd = genpwd;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	
	
	
}
