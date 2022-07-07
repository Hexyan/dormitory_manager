package com.dormitorymanager.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.dormitorymanager.entity.Admin;

public class AdminDao extends BaseDao<Admin> {
	/**
	 * �����û��������û���Ϣ
	 * @param name
	 * @return
	 */
	public Admin getAdmin(String name){
		Admin admin = null;
		String sql = "select * from admin where name = '" + name + "'";
		try {
			PreparedStatement prepareStatement = con.prepareStatement(sql);
			ResultSet executeQuery = prepareStatement.executeQuery();
			if(executeQuery.next()){
				admin = new Admin();
				admin.setId(executeQuery.getInt("id"));
				admin.setName(executeQuery.getString("name"));
				admin.setPassword(executeQuery.getString("password"));
				admin.setStatus(executeQuery.getInt("status"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return admin;
	}
}
