package com.dormitorymanager.servlet;
import java.io.IOException;

import javax.servlet.ServletException;
/**
 * 登录
 */
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.formula.functions.T;

import com.dormitorymanager.bean.Operator;
import com.dormitorymanager.bean.Page;
import com.dormitorymanager.bean.SearchProperty;
import com.dormitorymanager.config.BaseConfig;
import com.dormitorymanager.dao.AdminDao;
import com.dormitorymanager.dao.DormitoryManagerDao;
import com.dormitorymanager.dao.StudentDao;
import com.dormitorymanager.entity.Admin;
import com.dormitorymanager.entity.DormitoryManager;
import com.dormitorymanager.entity.Student;
import com.dormitorymanager.util.StringUtil;

public class LoginServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5870852067427524781L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		String vcode = req.getParameter("vcode");
		String msg = "success";
		if(StringUtil.isEmpty(name)){
			msg = "用户名不能为空!";
		}
		if(StringUtil.isEmpty(password)){
			msg = "密码不能为空!";
		}
		if(StringUtil.isEmpty(vcode)){
			msg = "验证码不能为空!";
		}
		if("success".equals(msg)){
			Object loginCpacha = req.getSession().getAttribute("loginCpacha");
			if(loginCpacha == null){
				msg = "session已过期，请刷新页面后重试！";
			}else{
				if(!vcode.toUpperCase().equals(loginCpacha.toString().toUpperCase())){
					msg = "验证码错误";
				}
			}
			
		}
		if("success".equals(msg)){
			String typeString = req.getParameter("type");
			try {
				int type = Integer.parseInt(typeString);
				if(type == 1){
					//超级管理员用户
					AdminDao adminDao = new AdminDao();
					Admin admin = adminDao.getAdmin(name);
					adminDao.closeConnection();
					if(admin == null){
						msg = "不存在该用户！";
					}
					if(admin != null){
						if(!password.equals(admin.getPassword())){
							msg = "密码错误！";
						}else{
							if(admin.getStatus() == BaseConfig.ADMIN_STATUS_DISAABLE){
								msg = "该用户状态不可用，请联系管理员！";
							}else{
								req.getSession().setAttribute("user", admin);
								req.getSession().setAttribute("userType", type);
							}
						}
					}
				}else if(type == 2){
					//学生登录
					StudentDao studentDao = new StudentDao();
					Page<Student> page = new Page<Student>(1, 10);
					page.getSearchProperties().add(new SearchProperty("sn", name, Operator.EQ));
					Page<Student> studentPage = studentDao.findList(page);
					studentDao.closeConnection();
					if(studentPage.getConten().size() == 0){
						msg = "不存在该用户！";
					}else{
						Student student = studentPage.getConten().get(0);
						if(!password.equals(student.getPassword())){
							msg = "密码错误！";
						}else{
							req.getSession().setAttribute("user", student);
							req.getSession().setAttribute("userType", type);
						}
					}
					
				}else if(type == 3){
					//宿管登录
					DormitoryManagerDao dormitoryManagerDao = new DormitoryManagerDao();
					Page<DormitoryManager> page = new Page<DormitoryManager>(1, 10);
					page.getSearchProperties().add(new SearchProperty("sn", name, Operator.EQ));
					page = dormitoryManagerDao.findList(page);
					dormitoryManagerDao.closeConnection();
					if(page.getConten().size() == 0){
						msg = "不存在该用户！";
					}else{
						DormitoryManager dormitoryManager = page.getConten().get(0);
						if(!password.equals(dormitoryManager.getPassword())){
							msg = "密码错误！";
						}else{
							req.getSession().setAttribute("user", dormitoryManager);
							req.getSession().setAttribute("userType", type);
						}
					}
				}else{
					msg = "用户类型错误";
				}
			} catch (Exception e) {
				// TODO: handle exception
				msg = "用户类型错误！";
			}
		}
		resp.setCharacterEncoding("utf-8");
		resp.getWriter().write(msg);
	}
}
