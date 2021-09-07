package cn.xjfd.ssm.pojo;

public class ReportLossEleData {
	private String name;
	private double gridErrStopHour;
	private double weaErrStopHour;
	private double hMIStopHour;
    private double remoteStopHour;
	private double errBreakHour;
	private double powLimHour;
	private double gridErrPowSum;
	private double weaErrPowSum;
	private double hMIStopPowSum;
	private double remoteStopPowSum;
	private double errBreakPowSum;
	private double powLimPowSum;
	private double hiddenPow;
	private double capAva;
	private double avaHours;
	private double hoursSum;
	private double lossGenSum;
	
	public ReportLossEleData(String name, double gridErrStopHour,double weaErrStopHour, double hMIStopHour,double remoteStopHour,double errBreakHour,double powLimHour,double gridErrPowSum,double weaErrPowSum,double hMIStopPowSum,double remoteStopPowSum,double errBreakPowSum,double powLimPowSum,double hiddenPow,double capAva,double avaHours,double hoursSum,double lossGenSum) {
		super();
		this.name = name;
		this.gridErrStopHour = gridErrStopHour;
		this.weaErrStopHour = weaErrStopHour;
		this.hMIStopHour = hMIStopHour;
		this.remoteStopHour = remoteStopHour;
		this.errBreakHour = errBreakHour;
		this.powLimHour = powLimHour;
		this.gridErrPowSum = gridErrPowSum;
		this.weaErrPowSum = weaErrPowSum;
		this.hMIStopPowSum = hMIStopPowSum;
		this.remoteStopPowSum = remoteStopPowSum;
		this.errBreakPowSum = errBreakPowSum;
		this.powLimPowSum = powLimPowSum;
		this.hiddenPow = hiddenPow;
		this.capAva = capAva;
		this.avaHours = avaHours;
		this.hoursSum = hoursSum;
		this.lossGenSum = lossGenSum;
	}
	public ReportLossEleData() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getGridErrStopHour() {
		return gridErrStopHour;
	}
	public void setGridErrStopHour(double gridErrStopHour) {
		this.gridErrStopHour = gridErrStopHour;
	}
	public double getWeaErrStopHour() {
		return weaErrStopHour;
	}
	public void setWeaErrStopHour(double weaErrStopHour) {
		this.weaErrStopHour = weaErrStopHour;
	}
	public double gethMIStopHour() {
		return hMIStopHour;
	}
	public void sethMIStopHour(double hMIStopHour) {
		this.hMIStopHour = hMIStopHour;
	}
	public double getRemoteStopHour() {
		return remoteStopHour;
	}
	public void setRemoteStopHour(double remoteStopHour) {
		this.remoteStopHour = remoteStopHour;
	}
	public double getErrBreakHour() {
		return errBreakHour;
	}
	public void setErrBreakHour(double errBreakHour) {
		this.errBreakHour = errBreakHour;
	}
	public double getPowLimHour() {
		return powLimHour;
	}
	public void setPowLimHour(double powLimHour) {
		this.powLimHour = powLimHour;
	}
	public double getGridErrPowSum() {
		return gridErrPowSum;
	}
	public void setGridErrPowSum(double gridErrPowSum) {
		this.gridErrPowSum = gridErrPowSum;
	}
	public double getWeaErrPowSum() {
		return weaErrPowSum;
	}
	public void setWeaErrPowSum(double weaErrPowSum) {
		this.weaErrPowSum = weaErrPowSum;
	}
	public double gethMIStopPowSum() {
		return hMIStopPowSum;
	}
	public void sethMIStopPowSum(double hMIStopPowSum) {
		this.hMIStopPowSum = hMIStopPowSum;
	}
	public double getRemoteStopPowSum() {
		return remoteStopPowSum;
	}
	public void setRemoteStopPowSum(double remoteStopPowSum) {
		this.remoteStopPowSum = remoteStopPowSum;
	}
	public double getErrBreakPowSum() {
		return errBreakPowSum;
	}
	public void setErrBreakPowSum(double errBreakPowSum) {
		this.errBreakPowSum = errBreakPowSum;
	}
	public double getPowLimPowSum() {
		return powLimPowSum;
	}
	public void setPowLimPowSum(double powLimPowSum) {
		this.powLimPowSum = powLimPowSum;
	}
	public double getHiddenPow() {
		return hiddenPow;
	}
	public void setHiddenPow(double hiddenPow) {
		this.hiddenPow = hiddenPow;
	}
	public double getCapAva() {
		return capAva;
	}
	public void setCapAva(double capAva) {
		this.capAva = capAva;
	}
	public double getAvaHours() {
		return avaHours;
	}
	public void setAvaHours(double avaHours) {
		this.avaHours = avaHours;
	}
	public double getHoursSum() {
		return hoursSum;
	}
	public void setHoursSum(double hoursSum) {
		this.hoursSum = hoursSum;
	}
	public double getLossGenSum() {
		return lossGenSum;
	}
	public void setLossGenSum(double lossGenSum) {
		this.lossGenSum = lossGenSum;
	}
	
}
