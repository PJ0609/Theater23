package theater.screening;

import java.sql.Timestamp;

public class ScreenDTO {
	private int mov_id;
	private String mov_name;
	private int scn_id;
	private String scn_type;
	private Timestamp scn_time;
	private Timestamp end_time;
	private int remaining_seats;
	private String resv_seat;

	public int getMov_id() {
		return mov_id;
	}

	public String getMov_name() {
		return mov_name;
	}

	public int getScn_id() {
		return scn_id;
	}

	public String getScn_type() {
		return scn_type;
	}

	public Timestamp getScn_time() {
		return scn_time;
	}

	public Timestamp getEnd_time() {
		return end_time;
	}

	public int getRemaining_seats() {
		return remaining_seats;
	}

	public String getResv_seat() {
		return resv_seat;
	}

	public void setMov_id(int mov_id) {
		this.mov_id = mov_id;
	}

	public void setMov_name(String mov_name) {
		this.mov_name = mov_name;
	}

	public void setScn_id(int scn_id) {
		this.scn_id = scn_id;
	}

	public void setScn_type(String scn_type) {
		this.scn_type = scn_type;
	}

	public void setScn_time(Timestamp scn_time) {
		this.scn_time = scn_time;
	}

	public void setEnd_time(Timestamp end_time) {
		this.end_time = end_time;
	}

	public void setRemaining_seats(int remaining_seats) {
		this.remaining_seats = remaining_seats;
	}

	public void setResv_seat(String resv_seat) {
		this.resv_seat = resv_seat;
	}

}
