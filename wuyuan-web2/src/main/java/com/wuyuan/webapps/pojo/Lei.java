package com.wuyuan.webapps.pojo;

public class Lei {
	private int id;//id(方块的id：1-480)
	private int roundNum;//周围雷的个数。包括0个
	private String leiIds;//周围雷的id。用,隔开
	private String roundIds;//周围8个方块的id。用,隔开
	private boolean hasLei;//此处有无雷
	public int getRoundNum() {
		return roundNum;
	}
	public String getRoundIds() {
		return roundIds;
	}
	public void setRoundIds(String roundIds) {
		this.roundIds = roundIds;
	}
	public void setRoundNum(int roundNum) {
		this.roundNum = roundNum;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLeiIds() {
		return leiIds;
	}
	public void setLeiIds(String leiIds) {
		this.leiIds = leiIds;
	}
	public boolean isHasLei() {
		return hasLei;
	}
	public void setHasLei(boolean hasLei) {
		this.hasLei = hasLei;
	}
}
