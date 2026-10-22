package com.fuao.fajxc.bussiness.commodity;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Model;

/**
 * 商品型号业务逻辑层接口
 * @author 14012
 *
 */
public interface CommodityModelBussiness {
	/**
	 * 根据商品类别ID查询所以商品型号
	 * @param id 商品类别ID
	 * @return List 符合条件的商品型号列表
	 */
	public List select(String id);
	
	/**
	 * 查询商品型号
	 */
	public Model getModel(String id);
	
	/**
	 * 根据型号和仓库查找数量
	 */
	public int selsomeModel(int modelId,int depId);
	
	/**
	 * 查询型号机柜的型号列表
	 */
	public List getCabinetList();

	/**
	 * 分页查询商品型号
	 */
	public Pages getList(String hql,int pageNo ,int pageSize,Object... value);

}
