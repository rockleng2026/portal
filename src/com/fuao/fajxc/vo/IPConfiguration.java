package com.fuao.fajxc.vo;
// default package



/**
 * IPConfiguration entity. @author MyEclipse Persistence Tools
 */

public class IPConfiguration  implements java.io.Serializable {


    // Fields    

     private Integer ipcId;
     private Property Tproperty =  new Property();
//     private StorageInfo TstorageInfo = new StorageInfo();
     private Depot  Tdepot = new Depot();
     private String ipcname;
     private String ipcaddress;
     private String ipcarrier;
     private String ipcstate;
     private UpServer upNo;
     private String isblack;//É¾³ý±êÊ¶
     
     
    // ConstructorsR

   


	/** default constructor */
    public IPConfiguration() {
    	
    	
    }

    
    public UpServer getUpNo() {
		return upNo;
	}


	public void setUpNo(UpServer upNo) {
		this.upNo = upNo;
	}


	/** full constructor */
    public IPConfiguration(String ipcname, String ipcaddress, String ipcarrier,String ipcstate,String isblack) {
        this.ipcname = ipcname;
        this.ipcaddress = ipcaddress;
        this.ipcarrier = ipcarrier;
        this.ipcstate = ipcstate;
        this.isblack = isblack;
    }

   
    // Property accessors

    
    public Integer getIpcId() {
        return this.ipcId;
    }
    
    public String getIsblack() {
		return isblack;
	}


	public void setIsblack(String isblack) {
		this.isblack = isblack;
	}


	public void setIpcId(Integer ipcId) {
        this.ipcId = ipcId;
    }
    

    public String getIpcstate() {
		return ipcstate;
	}


	public void setIpcstate(String ipcstate) {
		this.ipcstate = ipcstate;
	}


	public Property getTproperty() {
		return Tproperty;
	}


	public void setTproperty(Property tproperty) {
		Tproperty = tproperty;
	}


//	public StorageInfo getTstorageInfo() {
//		return TstorageInfo;
//	}
//
//
//	public void setTstorageInfo(StorageInfo tstorageInfo) {
//		TstorageInfo = tstorageInfo;
//	}


	public Depot getTdepot() {
		return Tdepot;
	}


	public void setTdepot(Depot tdepot) {
		Tdepot = tdepot;
	}


	public String getIpcname() {
        return this.ipcname;
    }
    
    public void setIpcname(String ipcname) {
        this.ipcname = ipcname;
    }

    public String getIpcaddress() {
        return this.ipcaddress;
    }
    
    public void setIpcaddress(String ipcaddress) {
        this.ipcaddress = ipcaddress;
    }

    public String getIpcarrier() {
        return this.ipcarrier;
    }
    
    public void setIpcarrier(String ipcarrier) {
        this.ipcarrier = ipcarrier;
    }
   








}