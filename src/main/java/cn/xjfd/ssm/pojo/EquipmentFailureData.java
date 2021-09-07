package cn.xjfd.ssm.pojo;

public class EquipmentFailureData {

	private int gid;
	private String name;
	private String failName;
	private String happenTime;
	private String removeTime;
	private String curcmpState;
	
	
	public EquipmentFailureData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public EquipmentFailureData(int gid, String name, String failName, String happenTime, String removeTime,
			String curcmpState) {
		super();
		this.gid = gid;
		this.name = name;
		this.failName = failName;
		this.happenTime = happenTime;
		this.removeTime = removeTime;
		this.curcmpState = curcmpState;
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
	public String getFailName() {
		return failName;
	}
	public void setFailName(String failName) {
		this.failName = failName;
	}
	public String getHappenTime() {
		return happenTime;
	}
	public void setHappenTime(String happenTime) {
		this.happenTime = happenTime;
	}
	public String getRemoveTime() {
		return removeTime;
	}
	public void setRemoveTime(String removeTime) {
		this.removeTime = removeTime;
	}
	public String getCurcmpState() {
		return curcmpState;
	}
	public void setCurcmpState(String curcmpState) {
		this.curcmpState = curcmpState;
	}
	
	
	
}
