package theater.visitor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import theater.common.JDBCUtil;

public class VisitorDAO {
	private VisitorDAO() {};
	
	private static VisitorDAO instance = new VisitorDAO();
	
	public static VisitorDAO getInstance() {
		return instance;
	}
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private final String LOGIN_CHK = "select * from visitor where id=? and pwd=?";
	private final String ID_CHK = "select * from visitor where id=?";
	private final String INSERT_VISITOR = "insert into visitor(id, pwd, name, gender, tel, email, birthday, address1, address2) values(?,?,?,?,?,?,?,?,?)";
	private final String UPDATE_VISITOR = "update visitor set pwd=?, name=?, gender=?, tel=?, email=?, birthday=?, address1=?, address2=? where id=? and pwd=?";
	private final String DELETE_VISITOR = "delete from visitor where id=? and pwd=?";
	
	
	// 로그인 확인
	// 아이디와 비번이 일치하면 1, 아니면 0
	public int loginChk(String id, String pwd) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(LOGIN_CHK);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()) chk = 1;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}
	
	// 중복 아이디 체크
	// 중복 존재시 1, 중복 없으면 0
	public int idChk(String id) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(ID_CHK);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) chk = 1;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}

	// 회원 추가
	public int insertVisitor(VisitorDTO visitor) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(INSERT_VISITOR);
			pstmt.setString(1, visitor.getId());
			pstmt.setString(2, visitor.getPwd());
			pstmt.setString(3, visitor.getName());
			pstmt.setString(4,  String.valueOf(visitor.getGender()));
			pstmt.setString(5, visitor.getTel());
			pstmt.setString(6, visitor.getEmail());
			pstmt.setString(7, visitor.getBirthday());
			pstmt.setString(8, visitor.getAddress1());
			pstmt.setString(9, visitor.getAddress2());
			chk = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return chk;
	}
	// 회원 업데이트
	public int updateVisitor(VisitorDTO visitor) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_VISITOR);
			pstmt.setString(1, visitor.getPwd());
			pstmt.setString(2, visitor.getName());
			pstmt.setString(3, String.valueOf(visitor.getGender()));
			pstmt.setString(4, visitor.getTel());
			pstmt.setString(5, visitor.getEmail());
			pstmt.setString(6, visitor.getBirthday());
			pstmt.setString(7, visitor.getAddress1());
			pstmt.setString(8, visitor.getAddress2());
			pstmt.setString(9, visitor.getId());
			chk = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}
	// 회원 삭제
	public int deleteVisitor(String id, String pwd) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(DELETE_VISITOR);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return chk;
	}
	
}