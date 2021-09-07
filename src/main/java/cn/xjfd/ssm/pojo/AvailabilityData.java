package cn.xjfd.ssm.pojo;

public class AvailabilityData {

	private int id;
	private String name;
	private double totalTime;
	private double failDownTime;
	private double availableTime;
	private double availability;
	
	
	public AvailabilityData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AvailabilityData(int id, String name, double totalTime, double failDownTime, double availableTime,
			double availability) {
		super();
		this.id = id;
		this.name = name;
		this.totalTime = totalTime;
		this.failDownTime = failDownTime;
		this.availableTime = availableTime;
		this.availability = availability;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getTotalTime() {
		return totalTime;
	}
	public void setTotalTime(double totalTime) {
		this.totalTime = totalTime;
	}
	public double getFailDownTime() {
		return failDownTime;
	}
	public void setFailDownTime(double failDownTime) {
		this.failDownTime = failDownTime;
	}
	public double getAvailableTime() {
		return availableTime;
	}
	public void setAvailableTime(double availableTime) {
		this.availableTime = availableTime;
	}
	public double getAvailability() {
		return availability;
	}
	public void setAvailability(double availability) {
		this.availability = availability;
	}
	
	
}
