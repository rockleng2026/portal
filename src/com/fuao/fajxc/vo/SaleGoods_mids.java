package com.fuao.fajxc.vo;



/**
 * SaleGoods_mids entity. @author MyEclipse Persistence Tools
 */

public class SaleGoods_mids  implements java.io.Serializable {


    // Fields    

     private Integer sgmId;
     private Sale_orders sale_orders;
     private Sale_goods sale_goods;
     private Integer soOrderNumber;//商品数量
     private Integer soCheckStat;//审核状态

    // Constructors

    /** default constructor */
    public SaleGoods_mids() {
    }

    
    /** full constructor */
    public SaleGoods_mids(Sale_orders sale_orders, Sale_goods sale_goods, Integer soOrderNumber) {
        this.sale_orders = sale_orders;
        this.sale_goods = sale_goods;
        this.soOrderNumber = soOrderNumber;
    }

   
    // Property accessors

    public Integer getSgmId() {
        return this.sgmId;
    }
    
    public void setSgmId(Integer sgmId) {
        this.sgmId = sgmId;
    }

    public Sale_orders getSale_orders() {
        return this.sale_orders;
    }
    
    public void setSale_orders(Sale_orders sale_orders) {
        this.sale_orders = sale_orders;
    }

    public Sale_goods getSale_goods() {
        return this.sale_goods;
    }
    
    public void setSale_goods(Sale_goods sale_goods) {
        this.sale_goods = sale_goods;
    }

    public Integer getSoOrderNumber() {
        return this.soOrderNumber;
    }
    
    public void setSoOrderNumber(Integer soOrderNumber) {
        this.soOrderNumber = soOrderNumber;
    }


	public void setSoCheckStat(Integer soCheckStat) {
		this.soCheckStat = soCheckStat;
	}


	public Integer getSoCheckStat() {
		return soCheckStat;
	}
   








}