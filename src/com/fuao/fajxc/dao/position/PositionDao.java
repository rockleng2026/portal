package com.fuao.fajxc.dao.position;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.pagefunction;

public interface PositionDao extends BaseDao {
	
	/*******
	 * 查询所有的岗位列表
	 */
	public List getAllPositionList();
	/**
	 * 获取所有功能菜单
	 * @return
	 */
	public List<FunctionInfo> getAllFunctions();
	/**
	 * 获取superID下功能菜单
	 * @param superId
	 * @return
	 */
	public List<FunctionInfo> getFunctionsBySuperId(int superId);
	/**
	 * 查询岗位信息
	 * @param rolename
	 * @return
	 */
	public Workposition getObject(int positionid);
	/**
	 * 新增或修改岗位信息
	 * @param role
	 * @return
	 */
	public int addPosition(Workposition position);
	/**
	 * 修改岗位信息
	 * @param role
	 * @return
	 */
	public int updatePosition(Workposition position);
	/**
	 * 查询是否存在该角色
	 * @param roleid
	 * @return
	 */
	public boolean isExistsRole(String positionname);
	/**
	 * 查询角色信息
	 * @param rolename
	 * @return
	 */
	public Workposition getObject(String positionname);
	/*********
	 * 根据菜单页面编号得到其对应的页面功能集合
	 */
	public List<pagefunction> pagefunctionlist(int functionid);
	/*********
	 * 修改岗位信息
	 */
	public void update(Workposition position);

}
