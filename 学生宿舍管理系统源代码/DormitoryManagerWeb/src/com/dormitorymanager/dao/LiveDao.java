package com.dormitorymanager.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.dormitorymanager.entity.Live;
/**
 * 住宿数据库操作
 * 
 *
 */
public class LiveDao extends BaseDao<Live> {
	
	/**
	 * 判断学生是否已经入住
	 * @param studentId
	 * @return
	 */
	public boolean isLived(int studentId){
		String sql = "select count(id) as num from live where student_id = " + studentId;
		try {
			PreparedStatement prepareStatement = con.prepareStatement(sql);
			ResultSet executeQuery = prepareStatement.executeQuery();
			if(executeQuery.next()){
				return executeQuery.getInt("num") > 0;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
