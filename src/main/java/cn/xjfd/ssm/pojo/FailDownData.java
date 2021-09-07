package cn.xjfd.ssm.pojo;

import java.util.Date;

public class FailDownData {

	private Date happenTime;
	private Date removeTime;
	private String name;
	private int sid;
	private String curcmpState;
	private String windName;
	private int equipId;
	private int id;
	private long failDownTime;
	
	
	public FailDownData(Date happenTime, Date removeTime, String name, int sid, String curcmpState, String windName,
			int equipId, int id) {
		super();
		this.happenTime = happenTime;
		this.removeTime = removeTime;
		this.name = name;
		this.sid = sid;
		this.curcmpState = curcmpState;
		this.windName = windName;
		this.equipId = equipId;
		this.id = id;
	}
	public FailDownData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Date getHappenTime() {
		return happenTime;
	}
	public void setHappenTime(Date happenTime) {
		this.happenTime = happenTime;
	}
	public Date getRemoveTime() {
		return removeTime;
	}
	public void setRemoveTime(Date removeTime) {
		this.removeTime = removeTime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getCurcmpState() {
		return curcmpState;
	}
	public void setCurcmpState(String curcmpState) {
		this.curcmpState = curcmpState;
	}
	public String getWindName() {
		return windName;
	}
	public void setWindName(String windName) {
		this.windName = windName;
	}
	public int getEquipId() {
		return equipId;
	}
	public void setEquipId(int equipId) {
		this.equipId = equipId;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public float getFailDownTime() {
		return failDownTime;
	}
	public void setFailDownTime(long failDownTime) {
		this.failDownTime = failDownTime;
	}
	
}
