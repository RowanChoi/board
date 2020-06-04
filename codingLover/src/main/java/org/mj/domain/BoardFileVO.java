package org.mj.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardFileVO {
	private String fileNo;
	private int bno;
	private String fileName;
	private String filePath;
	private long fileSize;
	private Date fileRegdate;
	private String originFileName;
}
