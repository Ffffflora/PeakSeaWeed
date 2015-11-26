package com.peakcentre.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.peakcentre.web.dbc.DatabaseConnection;
import com.peakcentre.web.entity.TrainingPlan;
import com.peakcentre.web.entity.TrainingPlanDetail;
import com.peakcentre.web.entity.Userinfo;

//Used for Training Plan related database manipulation
public class TrainingPlanDao {

	private DatabaseConnection dbc;
	private Connection conn;

	//insert data into Training Plan table
	public boolean insertTrainingPlan(TrainingPlan tp) {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		PreparedStatement pstmt = null;

		boolean flag = false;

		try {
			boolean autoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			String sql = "INSERT INTO TrainingPlan(username,startdate,enddate) VALUES(?,?,?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, tp.getUsername());
			pstmt.setString(2, tp.getStartdate());
			pstmt.setString(3, tp.getEnddate());

			int rs = pstmt.executeUpdate();
			if (rs > 0) {
				flag = true;
			}
			conn.commit();
			conn.setAutoCommit(autoCommit);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}

		return flag;

	}

	//insert data into table TrainingPlanDetail
	public boolean insertTrainingPlanDetail(TrainingPlanDetail tpd) {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		PreparedStatement pstmt = null;

		boolean flag = false;

		try {
			boolean autoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			String sql = "INSERT INTO TrainingPlanDetail(tpid,username,week,zone,weekday,date,content) VALUES(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, tpd.getTpid());
			pstmt.setString(2, tpd.getUsername());
			pstmt.setInt(3, tpd.getWeek());
			pstmt.setInt(4, tpd.getZone());
			pstmt.setString(5, tpd.getWeekday());
			pstmt.setString(6, tpd.getDate());
			pstmt.setString(7, tpd.getContent());

			int rs = pstmt.executeUpdate();
			if (rs > 0) {
				flag = true;
			}
			conn.commit();
			conn.setAutoCommit(autoCommit);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		}

		return flag;

	}

	//Get current training plan id from table TrainingPlan
	public int getCurrentTrainingPlanId() {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		PreparedStatement pstmt = null;
		int id = 0;
		try {
			boolean autoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			String sql = "SELECT max(id) FROM TrainingPlan";
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				id = rs.getInt(1);
			}
			conn.commit();
			conn.setAutoCommit(autoCommit);

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}
		return id;
	}
}
