package theater.ticket;

import java.sql.Timestamp;

public class TicketDTO {
	private String resv_id;
	private int scn_id;
	private int mov_id;
	private String id;
	private String resv_type;
	private int theater;
	private Timestamp scn_time;
	private Timestamp end_time;
	private String seat;

	public String getResv_id() {
		return resv_id;
	}

	public int getScn_id() {
		return scn_id;
	}

	public int getMov_id() {
		return mov_id;
	}

	public String getId() {
		return id;
	}

	public String getResv_type() {
		return resv_type;
	}

	public int getTheater() {
		return theater;
	}

	public Timestamp getScn_time() {
		return scn_time;
	}

	public Timestamp getEnd_time() {
		return end_time;
	}

	public String getSeat() {
		return seat;
	}

	public void setResv_id(String resv_id) {
		this.resv_id = resv_id;
	}

	public void setScn_id(int scn_id) {
		this.scn_id = scn_id;
	}

	public void setMov_id(int mov_id) {
		this.mov_id = mov_id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setResv_type(String resv_type) {
		this.resv_type = resv_type;
	}

	public void setTheater(int theater) {
		this.theater = theater;
	}

	public void setScn_time(Timestamp scn_time) {
		this.scn_time = scn_time;
	}

	public void setEnd_time(Timestamp end_time) {
		this.end_time = end_time;
	}

	public void setSeat(String seat) {
		this.seat = seat;
	}

}
