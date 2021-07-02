package zuiop.xmlFileSearch.vo;

public class LocalApiVO {
    private String mgtNo;      
    private String opnSvcNm;   
    private String opnSvcId;  
    private String bplcNm;     
    private String siteTel;    
    private String siteWhlAddr;
    private String rdnWhlAddr; 
    private String rdnPostNo;  
    private String x;          
    private String y;          
    private String trdStateGbn;
    private String trdStateNm;
	public String getMgtNo() {
		return mgtNo;
	}
	public void setMgtNo(String mgtNo) {
		this.mgtNo = mgtNo;
	}
	public String getOpnSvcNm() {
		return opnSvcNm;
	}
	public void setOpnSvcNm(String opnSvcNm) {
		this.opnSvcNm = opnSvcNm;
	}
	public String getOpnSvcId() {
		return opnSvcId;
	}
	public void setOpnSvcId(String opnSvcId) {
		this.opnSvcId = opnSvcId;
	}
	public String getBplcNm() {
		return bplcNm;
	}
	public void setBplcNm(String bplcNm) {
		this.bplcNm = bplcNm;
	}
	public String getSiteTel() {
		return siteTel;
	}
	public void setSiteTel(String siteTel) {
		this.siteTel = siteTel;
	}
	public String getSiteWhlAddr() {
		return siteWhlAddr;
	}
	public void setSiteWhlAddr(String siteWhlAddr) {
		this.siteWhlAddr = siteWhlAddr;
	}
	public String getRdnWhlAddr() {
		return rdnWhlAddr;
	}
	public void setRdnWhlAddr(String rdnWhlAddr) {
		this.rdnWhlAddr = rdnWhlAddr;
	}
	public String getRdnPostNo() {
		return rdnPostNo;
	}
	public void setRdnPostNo(String rdnPostNo) {
		this.rdnPostNo = rdnPostNo;
	}
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public String getTrdStateGbn() {
		return trdStateGbn;
	}
	public void setTrdStateGbn(String trdStateGbn) {
		this.trdStateGbn = trdStateGbn;
	}
	public String getTrdStateNm() {
		return trdStateNm;
	}
	public void setTrdStateNm(String trdStateNm) {
		this.trdStateNm = trdStateNm;
	}
	@Override
	public String toString() {
		return "LocalApiVO [mgtNo=" + mgtNo + ", opnSvcNm=" + opnSvcNm + ", opnSvcId=" + opnSvcId + ", bplcNm=" + bplcNm
				+ ", siteTel=" + siteTel + ", siteWhlAddr=" + siteWhlAddr + ", rdnWhlAddr=" + rdnWhlAddr
				+ ", rdnPostNo=" + rdnPostNo + ", x=" + x + ", y=" + y + ", trdStateGbn=" + trdStateGbn
				+ ", trdStateNm=" + trdStateNm + "]";
	} 
}
