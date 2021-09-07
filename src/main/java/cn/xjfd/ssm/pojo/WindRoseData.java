package cn.xjfd.ssm.pojo;

public class WindRoseData {

	private int windDirectionId;
	private String windDirection;
	private String avgWindSpeed;
	private double windDirectionFrequency;
	private double windEnergy;
	private String avgPower;
	private int frequency;
	
	
	public WindRoseData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public WindRoseData(int windDirectionId, String windDirection, String avgWindSpeed, double windDirectionFrequency,
			double windEnergy, String avgPower, int frequency) {
		super();
		this.windDirectionId = windDirectionId;
		this.windDirection = windDirection;
		this.avgWindSpeed = avgWindSpeed;
		this.windDirectionFrequency = windDirectionFrequency;
		this.windEnergy = windEnergy;
		this.avgPower = avgPower;
		this.frequency = frequency;
	}
	public int getWindDirectionId() {
		return windDirectionId;
	}
	public void setWindDirectionId(int windDirectionId) {
		this.windDirectionId = windDirectionId;
	}
	public String getWindDirection() {
		return windDirection;
	}
	public void setWindDirection(String windDirection) {
		this.windDirection = windDirection;
	}
	public String getAvgWindSpeed() {
		return avgWindSpeed;
	}
	public void setAvgWindSpeed(String avgWindSpeed) {
		this.avgWindSpeed = avgWindSpeed;
	}
	public double getWindDirectionFrequency() {
		return windDirectionFrequency;
	}
	public void setWindDirectionFrequency(double windDirectionFrequency) {
		this.windDirectionFrequency = windDirectionFrequency;
	}
	public double getWindEnergy() {
		return windEnergy;
	}
	public void setWindEnergy(double windEnergy) {
		this.windEnergy = windEnergy;
	}
	public String getAvgPower() {
		return avgPower;
	}
	public void setAvgPower(String avgPower) {
		this.avgPower = avgPower;
	}
	public int getFrequency() {
		return frequency;
	}
	public void setFrequency(int frequency) {
		this.frequency = frequency;
	}
	
	
}
