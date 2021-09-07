package cn.xjfd.ssm.pojo;

public class ReportDayData {

	private String name;
	private int id;
	private double max_windspeed;
	private double avg_windspeed;
	private double min_windspeed;
	private double max_P;
	private double avg_P;
	private double min_P;
	private double max_Q;
	private double avg_Q;
	private double min_Q;
	private double max_Temp;
	private double avg_Temp;
	private double min_Temp;
	private double LftHour;
	private double RtghHour;
	private double YawHour;
	private int LftYawMotorCWCou;
	private int RtghYawMotorCCWCou;
	private int YawCWCou;
	private double daygenwh;
	private int WinTurStCovCont;
	private int SerModTimes;
	private int WinTurErrCovCont;
	private int ConvMaiSwitchCou;
	private int WinHigErrTimes;
	private int WinTurCatInCont;
	private int WinTurArtStpCont;
	
	
	
	public ReportDayData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReportDayData(String name, int id, double max_windspeed, double avg_windspeed, double min_windspeed,
			double max_P, double avg_P, double min_P, double max_Q, double avg_Q, double min_Q, double max_Temp,
			double avg_Temp, double min_Temp, double lftHour, double rtghHour, double yawHour, int lftYawMotorCWCou,
			int rtghYawMotorCCWCou, int yawCWCouYawCWCou, double daygenwh, int winTurStCovCont, int serModTimes,
			int winTurErrCovCont, int convMaiSwitchCou, int winHigErrTimes, int winTurCatInCont, int winTurArtStpCont) {
		super();
		this.name = name;
		this.id = id;
		this.max_windspeed = max_windspeed;
		this.avg_windspeed = avg_windspeed;
		this.min_windspeed = min_windspeed;
		this.max_P = max_P;
		this.avg_P = avg_P;
		this.min_P = min_P;
		this.max_Q = max_Q;
		this.avg_Q = avg_Q;
		this.min_Q = min_Q;
		this.max_Temp = max_Temp;
		this.avg_Temp = avg_Temp;
		this.min_Temp = min_Temp;
		LftHour = lftHour;
		RtghHour = rtghHour;
		YawHour = yawHour;
		LftYawMotorCWCou = lftYawMotorCWCou;
		RtghYawMotorCCWCou = rtghYawMotorCCWCou;

		this.daygenwh = daygenwh;
		WinTurStCovCont = winTurStCovCont;
		SerModTimes = serModTimes;
		WinTurErrCovCont = winTurErrCovCont;
		ConvMaiSwitchCou = convMaiSwitchCou;
		WinHigErrTimes = winHigErrTimes;
		WinTurCatInCont = winTurCatInCont;
		WinTurArtStpCont = winTurArtStpCont;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getMax_windspeed() {
		return max_windspeed;
	}
	public void setMax_windspeed(double max_windspeed) {
		this.max_windspeed = max_windspeed;
	}
	public double getAvg_windspeed() {
		return avg_windspeed;
	}
	public void setAvg_windspeed(double avg_windspeed) {
		this.avg_windspeed = avg_windspeed;
	}
	public double getMin_windspeed() {
		return min_windspeed;
	}
	public void setMin_windspeed(double min_windspeed) {
		this.min_windspeed = min_windspeed;
	}
	public double getMax_P() {
		return max_P;
	}
	public void setMax_P(double max_P) {
		this.max_P = max_P;
	}
	public double getAvg_P() {
		return avg_P;
	}
	public void setAvg_P(double avg_P) {
		this.avg_P = avg_P;
	}
	public double getMin_P() {
		return min_P;
	}
	public void setMin_P(double min_P) {
		this.min_P = min_P;
	}
	public double getMax_Q() {
		return max_Q;
	}
	public void setMax_Q(double max_Q) {
		this.max_Q = max_Q;
	}
	public double getAvg_Q() {
		return avg_Q;
	}
	public void setAvg_Q(double avg_Q) {
		this.avg_Q = avg_Q;
	}
	public double getMin_Q() {
		return min_Q;
	}
	public void setMin_Q(double min_Q) {
		this.min_Q = min_Q;
	}
	public double getMax_Temp() {
		return max_Temp;
	}
	public void setMax_Temp(double max_Temp) {
		this.max_Temp = max_Temp;
	}
	public double getAvg_Temp() {
		return avg_Temp;
	}
	public void setAvg_Temp(double avg_Temp) {
		this.avg_Temp = avg_Temp;
	}
	public double getMin_Temp() {
		return min_Temp;
	}
	public void setMin_Temp(double min_Temp) {
		this.min_Temp = min_Temp;
	}
	public double getLftHour() {
		return LftHour;
	}
	public void setLftHour(double lftHour) {
		LftHour = lftHour;
	}
	public double getRtghHour() {
		return RtghHour;
	}
	public void setRtghHour(double rtghHour) {
		RtghHour = rtghHour;
	}
	public double getYawHour() {
		return YawHour;
	}
	public void setYawHour(double yawHour) {
		YawHour = yawHour;
	}
	public int getLftYawMotorCWCou() {
		return LftYawMotorCWCou;
	}
	public void setLftYawMotorCWCou(int lftYawMotorCWCou) {
		LftYawMotorCWCou = lftYawMotorCWCou;
	}
	public int getRtghYawMotorCCWCou() {
		return RtghYawMotorCCWCou;
	}
	public void setRtghYawMotorCCWCou(int rtghYawMotorCCWCou) {
		RtghYawMotorCCWCou = rtghYawMotorCCWCou;
	}
	
	public int getYawCWCou() {
		return YawCWCou;
	}
	public void setYawCWCou(int yawCWCou) {
		YawCWCou = yawCWCou;
	}
	public double getDaygenwh() {
		return daygenwh;
	}
	public void setDaygenwh(double daygenwh) {
		this.daygenwh = daygenwh;
	}
	public int getWinTurStCovCont() {
		return WinTurStCovCont;
	}
	public void setWinTurStCovCont(int winTurStCovCont) {
		WinTurStCovCont = winTurStCovCont;
	}
	public int getSerModTimes() {
		return SerModTimes;
	}
	public void setSerModTimes(int serModTimes) {
		SerModTimes = serModTimes;
	}
	public int getWinTurErrCovCont() {
		return WinTurErrCovCont;
	}
	public void setWinTurErrCovCont(int winTurErrCovCont) {
		WinTurErrCovCont = winTurErrCovCont;
	}
	public int getConvMaiSwitchCou() {
		return ConvMaiSwitchCou;
	}
	public void setConvMaiSwitchCou(int convMaiSwitchCou) {
		ConvMaiSwitchCou = convMaiSwitchCou;
	}
	public int getWinHigErrTimes() {
		return WinHigErrTimes;
	}
	public void setWinHigErrTimes(int winHigErrTimes) {
		WinHigErrTimes = winHigErrTimes;
	}
	public int getWinTurCatInCont() {
		return WinTurCatInCont;
	}
	public void setWinTurCatInCont(int winTurCatInCont) {
		WinTurCatInCont = winTurCatInCont;
	}
	public int getWinTurArtStpCont() {
		return WinTurArtStpCont;
	}
	public void setWinTurArtStpCont(int winTurArtStpCont) {
		WinTurArtStpCont = winTurArtStpCont;
	}
	
	
}
