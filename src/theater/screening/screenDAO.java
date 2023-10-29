package theater.screening;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import theater.common.JDBCUtil;

public class screenDAO {
	private screenDAO() {};
	
	private static screenDAO instance = new screenDAO();
	
	public static screenDAO getInstance() {
		return instance;
	}
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public final String INSERT_SCREEN = "insert into screening(mov_id, mov_name, scn_id, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(?,?,?,?,?,?,?,?)";
	public final String UPDATE_SCREEN = "update screening set mov_id=?, mov_name=?, scn_id=?, scn_type=?, scn_time=?, end_time=?, remaining_seats=?";
	public final String DELETE_SCREEN = "delete from screening where scn_id=?";

	// 상영 추가
	public int insertScreen(screenDTO screen) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(INSERT_SCREEN);
			pstmt.setInt(1, screen.getMov_id());
			pstmt.setString(2, screen.getMov_name());
			pstmt.setInt(3, screen.getScn_id());
			pstmt.setString(4, screen.getScn_type());
			pstmt.setTimestamp(5, screen.getScn_time());
			pstmt.setTimestamp(6, screen.getEnd_time());
			pstmt.setInt(7, screen.getRemaining_seats());
			pstmt.setString(8, screen.getResv_seat());
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}
	
	// 상영 변경
	public int updateScreen(screenDTO screen) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_SCREEN);
			pstmt.setInt(1,screen.getMov_id());
			pstmt.setString(2,screen.getMov_name());
			pstmt.setInt(3,screen.getScn_id());
			pstmt.setString(4,screen.getScn_type());
			pstmt.setTimestamp(5,screen.getScn_time());
			pstmt.setTimestamp(6,screen.getEnd_time());
			pstmt.setInt(7,screen.getRemaining_seats());
			pstmt.setString(8,screen.getResv_seat());
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}
	
	// 상영 삭제 (단일)
		public int deleteScreen(String scn_id) {
			int chk = 0;
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(DELETE_SCREEN);
				pstmt.setString(1, scn_id);
				chk = pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return chk;
		}
	// 상영 삭제 (복수)
	public int deleteMovie(List<String> scn_id_array) {
		int chk = 0;
		String scn_ids = String.join(",", scn_id_array);
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement("delete from screening where scn_id in (" + scn_ids +")");
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}
	
}
