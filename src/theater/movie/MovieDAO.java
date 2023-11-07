package theater.movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
	
	private final String GET_MOVIE = "select * from movie where mov_id=?";
	private final String GET_MOVLIST = "select * from movie";
	private final String INSERT_MOVIE = "insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link) values(?,?,?,?,?,?,?,?,?)";
	private final String UPDATE_MOVIE = "update movie set mov_name=?, director=?, mov_img=?, genre=?, rating=?, synopsis=?, length=?, rel_date=?, trailer_link=? where mov_id=?";
	private final String DELETE_MOVIE = "delete movie where mov_id=?"; 
	
	// 영화 정보 가져오기
	public MovieDTO getMovie(int mov_id) {
		MovieDTO movie = new MovieDTO();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(GET_MOVIE);
			pstmt.setInt(1, mov_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				movie.setMov_id(mov_id);
				movie.setMov_name(rs.getString("mov_name"));
				movie.setDirector(rs.getString("director"));
				movie.setMov_img(rs.getString("mov_img"));
				movie.setGenre(rs.getString("genre"));
				movie.setRating(rs.getString("rating"));
				movie.setSynopsis(rs.getString("synopsis"));
				movie.setLength(rs.getInt("length"));
				movie.setRel_date(rs.getDate("rel_date"));
				movie.setTrailer_link(rs.getString("trailer_link"));				
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return movie;
	}
	
	// 영화 리스트 가져오기
	public List<MovieDTO> getMovList() {
		MovieDTO movie = null;
		List<MovieDTO> movies = new ArrayList<MovieDTO>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(GET_MOVLIST);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				movie = new MovieDTO();
				movie.setMov_id(rs.getInt("mov_id"));
				movie.setMov_name(rs.getString("mov_name"));
				movie.setDirector(rs.getString("director"));
				movie.setMov_img(rs.getString("mov_img"));
				movie.setGenre(rs.getString("genre"));
				movie.setRating(rs.getString("rating"));
				movie.setSynopsis(rs.getString("synopsis"));
				movie.setLength(rs.getInt("length"));
				movie.setRel_date(rs.getDate("rel_date"));
				movie.setTrailer_link(rs.getString("trailer_link"));
				movies.add(movie);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return movies;
	}
	// 영화 리스트 가져오기
	public List<MovieDTO> getMovList(List<Integer> mov_ids) {
		if( mov_ids == null || mov_ids.size() == 0 ) return null;
		MovieDTO movie = null;
		List<MovieDTO> movies = new ArrayList<MovieDTO>();
		String smov_ids = mov_ids.toString().substring(1, mov_ids.toString().length()-1);
		String sql = "select * from movie where mov_id in (" + smov_ids + ")";
		System.out.println(sql);
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				movie = new MovieDTO();
				movie.setMov_id(rs.getInt("mov_id"));
				movie.setMov_name(rs.getString("mov_name"));
				movie.setDirector(rs.getString("director"));
				movie.setMov_img(rs.getString("mov_img"));
				movie.setGenre(rs.getString("genre"));
				movie.setRating(rs.getString("rating"));
				movie.setSynopsis(rs.getString("synopsis"));
				movie.setLength(rs.getInt("length"));
				movie.setRel_date(rs.getDate("rel_date"));
				movie.setTrailer_link(rs.getString("trailer_link"));
				movies.add(movie);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return movies;
	}
	
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
			pstmt.setInt(10,movie.getMov_id());
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}
	
	// 영화 삭제 (단일)
		public int deleteMovie(int mov_id) {
			int chk = 0;
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(DELETE_MOVIE);
				pstmt.setInt(1, mov_id);
				chk = pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return chk;
		}
	// 영화 삭제 (복수)
	public int deleteMovie(String mov_ids) {
		int chk = 0;
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
