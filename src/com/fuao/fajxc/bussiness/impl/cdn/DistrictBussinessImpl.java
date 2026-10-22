package com.fuao.fajxc.bussiness.impl.cdn;

import com.fuao.fajxc.bussiness.cdn.DistrictBussiness;
import com.fuao.fajxc.dao.cdn.DistrictDao;
import com.fuao.fajxc.vo.District;



public class DistrictBussinessImpl implements DistrictBussiness {
	private DistrictDao districtdao;

	public DistrictDao getDistrictdao() {
		return districtdao;
	}

	public void setDistrictdao(DistrictDao districtdao) {
		this.districtdao = districtdao;
	}

	public District addDistrict(District district) {
		district=(District)districtdao.addReturnObject(district);
		return district;
	}
	
	



}
