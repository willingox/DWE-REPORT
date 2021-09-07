package cn.xjfd.ssm.pojo;

public class EffectiveHoursData {

	private int id;
	private String name;
	private int gid;
	private double effectiveHours;
	private double genwh;
	private double capacity;
	
	
	public EffectiveHoursData(int id, String name, int gid, double effectiveHours, double genwh, double capacity) {
		super();
		this.id = id;
		this.name = name;
		this.gid = gid;
		this.effectiveHours = effectiveHours;
		this.genwh = genwh;
		this.capacity = capacity;
	}
	public EffectiveHoursData() {
		super();
		// TODO Auto-generated constructor stub
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
	public int getGid() {
		return gid;
	}
	public void setGid(int gid) {
		this.gid = gid;
	}
	public double getEffectiveHours() {
		return effectiveHours;
	}
	public void setEffectiveHours(double effectiveHours) {
		this.effectiveHours = effectiveHours;
	}
	public double getGenwh() {
		return genwh;
	}
	public void setGenwh(double genwh) {
		this.genwh = genwh;
	}
	public double getCapacity() {
		return capacity;
	}
	public void setCapacity(double capacity) {
		this.capacity = capacity;
	}
	
	
}
