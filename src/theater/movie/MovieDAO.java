package theater.movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import theater.common.JDBCUtil;

public class MovieDAO {
	private MovieDAO() {};
	
	private static MovieDAO instance = new MovieDAO();
	
	public static MovieDAO getInstance() {
		return instance;
	}
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private final String INSERT_MOVIE = "insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link) values(?,?,?,?,?,?,?,?,?)";
	private final String UPDATE_MOVIE = "update movie set mov_name=?, director=?, mov_img=?, genre=?, rating=?, synopsis=?, length=?, rel_date=?, trailer_link=? where mov_id=?";
	private final String DELETE_MOVIE = "delete movie where mov_id=?"; 
	// 영화 추가
	public int insertMovie(MovieDTO movie) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(INSERT_MOVIE);
			pstmt.setString(1, movie.getMov_name());
			pstmt.setString(2, movie.getDirector());
			pstmt.setString(3, movie.getMov_img());
			pstmt.setString(4, movie.getGenre());
			pstmt.setString(5, movie.getRating());
			pstmt.setString(6, movie.getSynopsis());
			pstmt.setInt(7, movie.getLength());
			pstmt.setDate(8, movie.getRel_date());
			pstmt.setString(9, movie.getTrailer_link());
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}
	
	// 영화 변경
	public int updateMovie(MovieDTO movie) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_MOVIE);
			pstmt.setString(1,movie.getMov_name());
			pstmt.setString(2,movie.getDirector());
			pstmt.setString(3,movie.getMov_img());
			pstmt.setString(4,movie.getGenre());
			pstmt.setString(5,movie.getRating());
			pstmt.setString(6,movie.getSynopsis());
			pstmt.setInt(7,movie.getLength());
			pstmt.setDate(8,movie.getRel_date());
			pstmt.setString(9,movie.getTrailer_link());
			pstmt.setString(10,movie.getMov_id());
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}
	
	// 영화 삭제 (단일)
		public int deleteMovie(String mov_id) {
			int chk = 0;
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(DELETE_MOVIE);
				pstmt.setString(1, mov_id);
				chk = pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return chk;
		}
	// 영화 삭제 (복수)
	public int deleteMovie(List<String> mov_id_array) {
		int chk = 0;
		String mov_ids = String.join(",", mov_id_array);
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement("delete movie where mov_id in (" + mov_ids +")");
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}
}
