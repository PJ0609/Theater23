package theater.screen;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import theater.common.JDBCUtil;

public class ScreenDAO {
	private ScreenDAO() {};
	
	private static ScreenDAO instance = new ScreenDAO();
	
	public static ScreenDAO getInstance() {
		return instance;
	}
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public final String GET_MOV_BY_DATE = "select mov_id from screening where date(scn_time)=?";
	public final String GET_DATE_BY_MOV = "select date(scn_time) from screening where mov_id=?";
	public final String GET_SCNLIST = "select * from screening where mov_id=? and date(scn_time)=? order by theater, scn_type, scn_time";
	public final String GET_SCN_BY_ID = "select * from screening where scn_id=?";
	public final String INSERT_SCREEN = "insert into screening(mov_id, mov_name, theater, scn_type, scn_time, end_time, adult_price, teen_price, remaining_seats, resv_seat) values(?,?,?,?,?,?,?,?,?,?)";
	public final String UPDATE_SCREEN = "update screening set mov_id=?, mov_name=?, scn_id=?, theater=?, scn_type=?, scn_time=?, end_time=?, adult_price=?, teen_price=?, remaining_seats=? resv_seat=?";
	public final String DELETE_SCREEN = "delete from screening where scn_id=?";
	
	// 조회 메소드들 (~Qry)
	// 영화조회
	public List<Integer> getMovQry(List<String> theaters, List<String> dates) {
		List<Integer> mov_ids = new ArrayList<Integer>();
		String whereSql = theaters != null || dates != null ? "where " : "";
		String groupSql = "group by mov_id ";
		String theaterSql = "";
		String dateSql = "";

		if(theaters != null) {
			theaterSql = "theater in (" + String.join(",", theaters) + ") ";
		}
		if(dates != null) {
			List<String> sdates = new ArrayList();
			dates.forEach( e->sdates.add("'" + e + "'") );
			dateSql = "date(scn_time) in (" + String.join(",", sdates) + ") ";
		}
		String andSql = theaters != null && dates != null ? "and " : "";
		String sql = "select mov_id from screening " + whereSql + theaterSql + andSql + dateSql + groupSql;
		System.out.println(sql);
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				mov_ids.add(rs.getInt(1));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return mov_ids;
	}
	// 영화관 조회
	public List<Integer> getTheaterQry(List<String> mov_ids, List<String> dates) {
		List<Integer> theaters = new ArrayList<Integer>();
		String whereSql = mov_ids != null || dates != null ? "where " : "";
		String groupSql = "group by theater ";
		String movieSql = "";
		String dateSql = "";
		if(mov_ids != null) {
			movieSql = "mov_id in (" + String.join(",", mov_ids) + ") ";
		}
		if(dates != null) {
			List<String> sdates = new ArrayList();
			dates.forEach( e->sdates.add("'" + e + "'") );
			dateSql = "date(scn_time) in (" + String.join(",", sdates) + ") ";
		}
		String andSql = mov_ids != null && dates != null ? "and " : "";
		String sql = "select theater from screening " + whereSql + movieSql + andSql + dateSql + groupSql;
		System.out.println(sql);
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				theaters.add(rs.getInt(1));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return theaters;
		
	}
	// 상영일 조회 (refDay 필수)
	public List<LocalDate> getDateQry(List<String> mov_ids, List<String> theaters, LocalDate refDay) {
		List<LocalDate> dates = new ArrayList<LocalDate>();
		DateTimeFormatter dtf1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String and1Sql = (mov_ids != null || theaters != null) ? "and " : "";
		String movieSql = "";
		if(mov_ids != null) {
			movieSql = "mov_id in (" + String.join(",", mov_ids) + ") ";
		}
		String and2Sql = mov_ids != null && theaters != null ? "and " : "";
		String theaterSql = "";
		if(theaters != null) {
			theaterSql = "theater in (" + String.join(",", theaters) + ") ";
		}
		String groupSql = "group by fdate ";
		String sql = "select date(scn_time) as fdate from screening where date(scn_time) between '"+ refDay.format(dtf1)+ "' and '" + refDay.plusDays(21).format(dtf1) + "' " 
				+ and1Sql + movieSql + and2Sql + theaterSql + groupSql;
		System.out.println(sql);
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dates.add(rs.getDate(1).toLocalDate());
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return dates;
	}
	
	// 모든 조건하 상영조회
	// null이나 빈 문자열 비허용
	public List<ScreenDTO> getScreen(List<String> mov_ids, List<String> theaters, List<String> dates){
		List<ScreenDTO> screenList = new ArrayList<ScreenDTO>(); 
		ScreenDTO screen = null;
		String movieSql = "";
		String theaterSql = "";
		String dateSql = "";
		if(mov_ids != null) {
			movieSql = "mov_id in (" + String.join(",", mov_ids) + ") ";
		}
		if(theaters != null) {
			theaterSql = "theater in (" + String.join(",", theaters) + ") ";
		}
		if(dates != null) {
			List<String> sdates = new ArrayList();
			dates.forEach( e->sdates.add("'" + e + "'") );
			dateSql = "date(scn_time) in (" + String.join(",", sdates) + ") ";
		}
		String sql = "select * from screening where " + movieSql + "and " + theaterSql + "and " + dateSql;
		System.out.println(sql);
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				screen = new ScreenDTO();
				screen.setMov_id(rs.getInt("mov_id"));
				screen.setMov_name(rs.getString("mov_name"));
				screen.setTheater(rs.getInt("theater"));
				screen.setScn_id(rs.getInt("scn_id"));
				screen.setScn_type(rs.getString("scn_type"));
				screen.setScn_time(rs.getTimestamp("scn_time"));
				screen.setEnd_time(rs.getTimestamp("end_time"));
				screen.setAdult_price(rs.getInt("adult_price"));
				screen.setTeen_price(rs.getInt("teen_price"));
				screen.setRemaining_seats(rs.getInt("remaining_seats"));
				screen.setResv_seat(rs.getString("resv_seat"));
				screenList.add(screen);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return screenList;
	}
	
	
	//##############################################################
	// 상영일별 영화 조회
	public Set<Integer> getMovByDate(LocalDate ldate) {
		Set<Integer> mov_ids = new HashSet<Integer>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(GET_MOV_BY_DATE);
			pstmt.setDate(1, Date.valueOf(ldate));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				mov_ids.add(rs.getInt(1));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return mov_ids;
	}
	
	// 영화별 상영일 조회
	public List<LocalDate> getDateByMov(int mov_id){
		List<LocalDate> dates = new ArrayList<LocalDate>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(GET_DATE_BY_MOV);
			pstmt.setInt(1, mov_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dates.add(rs.getDate(1).toLocalDate());
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return dates;
	}
	
	
	
	// 영화별, 날짜별 상영 조회
	public List<ScreenDTO> getScnList(int mov_id, LocalDate scn_date){
		List<ScreenDTO> screenList = new ArrayList<ScreenDTO>();
		ScreenDTO screen = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(GET_SCNLIST);
			pstmt.setInt(1, mov_id);
			pstmt.setDate(2, Date.valueOf(scn_date));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				screen = new ScreenDTO();
				screen.setMov_id(rs.getInt("mov_id"));
				screen.setMov_name(rs.getString("mov_name"));
				screen.setTheater(rs.getInt("theater"));
				screen.setScn_id(rs.getInt("scn_id"));
				screen.setScn_type(rs.getString("scn_type"));
				screen.setScn_time(rs.getTimestamp("scn_time"));
				screen.setEnd_time(rs.getTimestamp("end_time"));
				screen.setAdult_price(rs.getInt("adult_price"));
				screen.setTeen_price(rs.getInt("teen_price"));
				screen.setRemaining_seats(rs.getInt("remaining_seats"));
				screen.setResv_seat(rs.getString("resv_seat"));
				screenList.add(screen);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return screenList;
	}
	
	// 상영 상세조회
	public ScreenDTO getScreen(int scn_id) {
		ScreenDTO screen = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(GET_SCN_BY_ID);
			pstmt.setInt(1, scn_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				screen = new ScreenDTO();
				screen.setMov_id(rs.getInt("mov_id"));
				screen.setMov_name(rs.getString("mov_name"));
				screen.setScn_id(rs.getInt("scn_id"));
				screen.setTheater(rs.getInt("theater"));
				screen.setScn_type(rs.getString("scn_type"));
				screen.setScn_time(rs.getTimestamp("scn_time"));
				screen.setEnd_time(rs.getTimestamp("end_time"));
				screen.setAdult_price(rs.getInt("adult_price"));
				screen.setTeen_price(rs.getInt("teen_price"));
				screen.setRemaining_seats(rs.getInt("remaining_seats"));
				screen.setResv_seat(rs.getString("resv_seat"));
			}	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return screen;
	}
	
	// 상영 추가
	public int insertScreen(ScreenDTO screen) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(INSERT_SCREEN);
			pstmt.setInt(1, screen.getMov_id());
			pstmt.setString(2, screen.getMov_name());
			pstmt.setInt(3, screen.getTheater());
			pstmt.setString(4, screen.getScn_type());
			pstmt.setTimestamp(5, screen.getScn_time());
			pstmt.setTimestamp(6, screen.getEnd_time());
			pstmt.setInt(7, screen.getAdult_price());
			pstmt.setInt(8, screen.getTeen_price());
			pstmt.setInt(9, screen.getRemaining_seats());
			pstmt.setString(10, screen.getResv_seat());
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return chk;
	}
	
	// 상영 변경
	public int updateScreen(ScreenDTO screen) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_SCREEN);
			pstmt.setInt(1,screen.getMov_id());
			pstmt.setString(2,screen.getMov_name());
			pstmt.setInt(3,screen.getScn_id());
			pstmt.setInt(4,screen.getTheater());
			pstmt.setString(5,screen.getScn_type());
			pstmt.setTimestamp(6,screen.getScn_time());
			pstmt.setTimestamp(7,screen.getEnd_time());
			pstmt.setInt(8, screen.getAdult_price());
			pstmt.setInt(9, screen.getTeen_price());
			pstmt.setInt(10,screen.getRemaining_seats());
			pstmt.setString(11,screen.getResv_seat());
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return chk;
	}
	
	// 상영 삭제 (단일)
		public int deleteScreen(int scn_id) {
			int chk = 0;
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(DELETE_SCREEN);
				pstmt.setInt(1, scn_id);
				chk = pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt);
			}
			return chk;
		}
	// 상영 삭제 (복수)
	public int deleteScreens(String scn_ids) {
		int chk = 0;
		//String scn_ids = String.join(",", scn_id_array);
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement("delete from screening where scn_id in (" + scn_ids +")");
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return chk;
	}
	
}
